-- True Hidden Everything
-- maniman303 and hawkidoki

-- Updated to CP77 1.5 with fixes and additions by
-- maniman303

-- GameUI, Cron and GameLocale
-- https://github.com/psiberx/cp2077-cet-kit

local GameUI = require('GameUI')
local Cron = require('Cron')
local Mod = require('Mod')
local Localization = require('Localization')
local enableNativeUI = true
local nativeSettings
local settingsTables = {}
local isInventorUIEnabled
local languageGroupPath = '/language'
local btnHideAppearanceCtrl = {}
local btnHideAppearance = {}

function InitNativeUI()
	nativeSettings = GetMod("nativeSettings")
	if enableNativeUI and nativeSettings then
		nativeSettings.addTab("/TrueHiddenEverything", "True Hidden Everything")
	end
end

function AddPreferencesUI(LanguageID)
	nativeSettings.addSubcategory("/TrueHiddenEverything/preferences",
		Localization.GetCategory(LanguageID, 'Preferences'), LanguageID)

	settingsTables['Inventory'] = nativeSettings.addSwitch(
		"/TrueHiddenEverything/preferences",
		Localization.GetName(LanguageID, 'Inventory'),
		Localization.GetDescription(LanguageID, 'Inventory'),
		Mod:GetPreference('Inventory') == 1,
		true,
		function(state)
			if state then
				Mod:SetPreference('Inventory', 1)
			else
				Mod:SetPreference('Inventory', 0)
			end
	end)
end

function AddVisibilityUI(LanguageID)
	nativeSettings.removeSubcategory("/TrueHiddenEverything/visibility")
	nativeSettings.removeSubcategory("/TrueHiddenEverything/disabled")
	nativeSettings.addSubcategory("/TrueHiddenEverything/visibility",
		Localization.GetCategory(LanguageID, 'Visibility'), 0)

	for iter, type in pairs(Mod.types) do
		settingsTables[type] = nativeSettings.addSwitch(
			"/TrueHiddenEverything/visibility",
			Localization.GetName(LanguageID, type),
			Localization.GetDescription(LanguageID, type),
			not Mod:IsHidden(type),
			true,
			function(state)
				Mod:Switch(type, not state)
		end)
	end
end

function RegisterNativeUI()
	languageID = Localization.GetLanguage()

	if enableNativeUI and nativeSettings then
		nativeSettings.removeSubcategory("/TrueHiddenEverything/preferences")

		AddVisibilityUI(languageID)
		--AddPreferencesUI(languageID)
	end
end

function DecreaseEventsSent()
	local events = Game.GetScriptableSystemsContainer():Get(CName.new('EquipmentSystem')):GetPlayerData(Game.GetPlayerSystem():GetLocalPlayerMainGameObject()).eventsSent
	Game.GetScriptableSystemsContainer():Get(CName.new('EquipmentSystem')):GetPlayerData(Game.GetPlayerSystem():GetLocalPlayerMainGameObject()).eventsSent = math.max(events - 1, 0)
end

function shouldDisplayControl(area)
	return area == gamedataEquipmentArea.Head or
		area == gamedataEquipmentArea.Face or
		area == gamedataEquipmentArea.Feet or
		area == gamedataEquipmentArea.Legs or
		area == gamedataEquipmentArea.InnerChest or
		area == gamedataEquipmentArea.OuterChest
end

registerForEvent('onInit', function()
	-- Mod Init
	Mod:Init()

	-- Native UI Init
	Localization.Initialize()
	InitNativeUI()
	RegisterNativeUI()

	languageGroupPath = CName.new(languageGroupPath)

	-- Update Native UI language
	Observe('SettingsMainGameController', 'OnVarModified', function(_, groupPath, varName, _, reason)
		if groupPath == languageGroupPath and reason == InGameConfigChangeReason.Accepted then
			RegisterNativeUI()
		end
	end)

	-- Inventory UI
	Override('InventoryDataManagerV2', 'IsTransmogEnabled', function()
		return 1
	end)

	-- Visiblity getters
	Override('EquipmentSystemPlayerData', 'IsVisualTagActive', function(self, Tag, Wrapped)
		local area = Mod.tagToArea[Tag.value]

		if area and Mod:IsHidden(area) and not Mod:GetBlockade(area) then
			return true
		else
			return Wrapped(Tag)
		end
	end)

	-- Update Inner chest
	-- Override('EquipmentSystemPlayerData', 'UpdateInnerChest', function(self, Wrapped)
	-- 	local itemID = self:GetActiveItem(gamedataEquipmentArea.InnerChest)
	-- 	if ItemID.IsValid(itemID) and not self:IsSlotHidden(gamedataEquipmentArea.InnerChest) then
	-- 		self:ResetItemAppearanceByTask(ts, gamedataEquipmentArea.InnerChest, true)
	-- 	end
	-- end)

	-- Transactions
	Override('TransactionSystem', 'ResetItemAppearance', function(self, obj, itemID, Wrapped)
		local equipmentSystem = Game.GetScriptableSystemsContainer():Get(CName.new('EquipmentSystem'))
		local area = equipmentSystem.GetEquipAreaType(itemID)

		if not (area.value == 'InnerChest' and (Mod:IsHidden('InnerChest') or Mod:GetBlockade('InnerChest'))) then
			Wrapped(obj, itemID)
		end
	end)

	-- On Clear Item
	Override('EquipmentSystemPlayerData', 'OnClearItemAppearance', function(self, resetItemID, Wrapped)
		self:OnUnequipProcessVisualTags(resetItemID, false)

		DecreaseEventsSent()

		self:FinalizeVisualTagProcessing()
	end)

	-- On Reset Item
	Override('EquipmentSystemPlayerData', 'OnResetItemAppearance', function(self, resetItemID, Wrapped)
		self:OnEquipProcessVisualTags(resetItemID)

		DecreaseEventsSent()

		self:FinalizeVisualTagProcessing()
	end)

	-- Make sure to remove hidden items
	Observe('EquipmentSystemPlayerData', 'RemoveEquipGLPs', function(_, itemID)
		local equipmentSystem = Game.GetScriptableSystemsContainer():Get(CName.new('EquipmentSystem'))
		local areaType = equipmentSystem.GetEquipAreaType(itemID)

		if Mod.Ready then
			if areaType.value == 'InnerChest' and Mod.Transaction:HasItemInSlot(Mod.Player, Mod.innerSlotTweakDB, itemID) then
				Mod.Transaction:RemoveItemFromSlot(Mod.Player, Mod.innerSlotTweakDB)
			elseif areaType.value == 'OuterChest' and Mod.Transaction:HasItemInSlot(Mod.Player, Mod.outerSlotTweakDB, itemID) then
				Mod.Transaction:RemoveItemFromSlot(Mod.Player, Mod.outerSlotTweakDB)
			elseif areaType.value == 'Legs' and Mod.Transaction:HasItemInSlot(Mod.Player, Mod.legsSlotTweakDB, itemID) then
				Mod.Transaction:RemoveItemFromSlot(Mod.Player, Mod.legsSlotTweakDB)
			end
		end
	end)

	-- Move items to extra slots
	Observe('EquipmentSystemPlayerData', 'ApplyEquipGLPs', function(_, itemID)
		local equipmentSystem = Game.GetScriptableSystemsContainer():Get(CName.new('EquipmentSystem'))
		local areaType = equipmentSystem.GetEquipAreaType(itemID)

		if Mod.Ready then
			Cron.After(0.3, function()
				if areaType.value == 'InnerChest' and Mod:ShouldShowBreast(1) and Mod.Transaction:HasItemInSlot(Mod.Player, TweakDBID('AttachmentSlots.Chest'), itemID) then
					Mod.Transaction:ChangeItemToSlot(Mod.Player, Mod.innerSlotTweakDB, itemID)
					Mod:Paperdoll('InnerChest')
				elseif areaType.value == 'OuterChest' and Mod:ShouldShowBreast(2) and Mod.Transaction:HasItemInSlot(Mod.Player, TweakDBID('AttachmentSlots.Torso'), itemID) then
					Mod.Transaction:ChangeItemToSlot(Mod.Player, Mod.outerSlotTweakDB, itemID)
					Mod:Paperdoll('OuterChest')
				elseif areaType.value == 'Legs' and Mod:ShouldShowGenitals() and Mod.Transaction:HasItemInSlot(Mod.Player, TweakDBID('AttachmentSlots.Legs'), itemID) then
					Mod.Transaction:ChangeItemToSlot(Mod.Player, Mod.legsSlotTweakDB, itemID)
					Mod:Paperdoll('Legs')
				elseif areaType.value == 'Invalid' then
					if Mod:ShouldShowGenitals() then
						Mod:ReEquipItem('Legs')
					end

					Cron.After(0.1, function()
						if Mod:ShouldShowBreast(1) then
							Mod:ReEquipItem('InnerChest')
						end
					end)

					Cron.After(0.2, function()
						if Mod:ShouldShowBreast(2) then
							Mod:ReEquipItem('OuterChest')
						end
					end)
				end
			end)
		end
	end)

	-- Don't add underwear
	Override('EquipmentSystemPlayerData', 'UnderwearEquipFailsafe', function(_, wrapped)
		local isGenitalVisible = false
		if Mod.Ready then
			local cus = Mod.Player:FindComponentByName('uiCharacterCustomizationGenitalsController0140')
			isGenitalVisible = cus and not cus.forceHideGenitals and Mod.Equipment:ShouldShowGenitals()
		end

		if isGenitalVisible then
			return true
		else
			return wrapped()
		end
	end)

	-- On Visual Tags
	Override('EquipmentSystemPlayerData', 'OnUnequipProcessVisualTags', function(self, itemID, isUnequipping, Wrapped)
		local equipmentSystem = Game.GetScriptableSystemsContainer():Get(CName.new('EquipmentSystem'))
		local transactionSystem = Game.GetTransactionSystem()
		local areaType = equipmentSystem.GetEquipAreaType(itemID)

		if Mod.Ready and ((areaType.value == 'Legs' and isUnequipping) or transactionSystem:IsSlotEmpty(self.owner, TweakDBID('AttachmentSlots.Legs'))) and self:ShouldShowGenitals() then
			local cus = Mod.Player:FindComponentByName('uiCharacterCustomizationGenitalsController0140')
			if cus and not cus.forceHideGenitals then
				transactionSystem:RemoveItemFromSlot(Mod.Player, TweakDBID.new("AttachmentSlots.UnderwearBottom"), true, false, true)
				Game.UnequipItem('UnderwearBottom', '0')
			end
		end

		Wrapped(itemID, isUnequipping)

		if (areaType.value == 'Head' or areaType.value == 'Face') and not Mod:IsHidden('InnerChest') then
			self:ResetItemAppearanceEvent('InnerChest')
		elseif areaType.value == 'Outfit' and isUnequipping then
			for iter, elem in pairs(Mod.types) do
				Mod:Switch(elem, Mod:IsHidden(elem), true)
			end
		end
	end)

	Override('EquipmentSystemPlayerData', 'OnEquipProcessVisualTags', function(self, itemID, Wrapped)
    	local visualTagsTweakDB = {}
    	local transactionSystem = Game.GetTransactionSystem()
		local equipmentSystem = Game.GetScriptableSystemsContainer():Get(CName.new('EquipmentSystem'))
    	local itemEntity = transactionSystem:GetItemInSlot(self.owner, equipmentSystem.GetPlacementSlot(itemID))
    	local areaType = equipmentSystem.GetEquipAreaType(itemID)
    	local tag = self:GetVisualTagByAreaType(areaType)

		if tag ~= Mod.emptyItemID and self:IsVisualTagActive(tag) then
			self:ClearItemAppearanceEvent(areaType)
		elseif itemEntity then
			visualTagsTweakDB = transactionSystem:GetVisualTagsByItemID(itemID, self.owner)
			for iter, elem in pairs(visualTagsTweakDB) do
				local slotInfoIndex = self:GetSlotsInfoIndex(elem)
				if slotInfoIndex > -1 and self.clothingSlotsInfo then
					local clothingSlotInfo = self.clothingSlotsInfo[slotInfoIndex + 1]
					--if clothingSlotInfo and clothingSlotInfo.areaType ~= areaType then
					if clothingSlotInfo then
						self:ClearItemAppearanceEvent(clothingSlotInfo.areaType)
					end
				end

				local shouldPartial = elem.value == 'hide_T1part' and not Mod:IsHidden('OuterChest')
				if areaType == gamedataEquipmentArea.OuterChest and self:IsPartialVisualTagActive(itemID, transactionSystem) and shouldPartial then
					self.isPartialVisualTagActive = true
          			self:UpdateInnerChest()
				end

				local isGenitalVisible = false
				if Mod.Ready then
					local cus = Mod.Player:FindComponentByName('uiCharacterCustomizationGenitalsController0140')
					isGenitalVisible = cus and not cus.forceHideGenitals
				end

				local isUnderwearHidden = self:IsUnderwearHidden()
				local areaEqualsUnderwear = areaType == gamedataEquipmentArea.UnderwearBottom
				local isItemValid = ItemID.IsValid(self:GetVisualItemInSlot(gamedataEquipmentArea.Legs))
				local isVisualTagActive = self:IsVisualTagActive(CName.new("hide_L1"))
				if (areaEqualsUnderwear or not isUnderwearHidden) and ((isVisualTagActive and not Mod:IsHidden('Legs')) or (self:ShouldShowGenitals() and isGenitalVisible and not isItemValid) or (isItemValid and not Mod:IsHidden('Legs'))) then
					self:ClearItemAppearanceEvent(gamedataEquipmentArea.UnderwearBottom)
				end

				isUnderwearHidden = self:EvaluateUnderwearTopHiddenState()
				areaEqualsUnderwear = areaType == gamedataEquipmentArea.UnderwearTop
				isItemValid = ItemID.IsValid(self:GetVisualItemInSlot(gamedataEquipmentArea.InnerChest))
				isVisualTagActive = self:IsVisualTagActive(CName.new("hide_T1"))
				if (areaEqualsUnderwear or not isUnderwearHidden) and self:IsBuildCensored() and (isItemValid or isVisualTagActive) then
					self:ClearItemAppearanceEvent(gamedataEquipmentArea.UnderwearTop)
				end
			end
		end

		if areaType.value == 'OuterChest' then
			visualTagsTweakDB = transactionSystem:GetVisualTagsByItemID(itemID, self.owner)
			self.isPartialVisualTagActive = false
			for iter, elem in pairs(visualTagsTweakDB) do
				if elem.value == 'hide_T1part' then
					self.isPartialVisualTagActive = not Mod:IsHidden('OuterChest')
				end
			end

			self:UpdateInnerChest()
		elseif (areaType.value == 'Head' or areaType.value == 'Face') and not Mod:IsHidden('InnerChest') then
			self:ResetItemAppearanceEvent('InnerChest')
		end
	end)

	-- Expand Slots
	Override('EquipmentSystemPlayerData', 'InitializeClothingSlotsInfo', function(self, Wrapped)
		Wrapped()
		local eyesCWSlot = self:CreateSlotInfo(gamedataEquipmentArea.EyesCW, "AttachmentSlots.EyesCW", CName("hide_F2"))
		table.insert(self.clothingSlotsInfo, eyesCWSlot)
		local silverhandArmSlot = self:CreateSlotInfo(gamedataEquipmentArea.EyesCW, "AttachmentSlots.SilverhandArm", CName("hide_SA"))
		table.insert(self.clothingSlotsInfo, silverhandArmSlot)
		local splinterSlot = self:CreateSlotInfo(gamedataEquipmentArea.Splinter, "AttachmentSlots.Splinter", CName("hide_SP"))
		table.insert(self.clothingSlotsInfo, splinterSlot)
	end)	

	-- GUI Toggle
	-- Override('InventoryItemDisplayController', 'UpdateTransmogControls', function(self, isEmpty, wrapped)
	-- 	local isItemHidden = false
	-- 	local area = self.equipmentArea
	-- 	local showcontrol = shouldDisplayControl(area) and not self.isLocked

	-- 	if not inkWidgetRef.IsValid(self.transmogContainer) then return end

	-- 	if showcontrol and not isEmpty then
	-- 		if btnHideAppearance[area] == nil then
	-- 			btnHideAppearance[area] = self:SpawnFromLocal(inkWidgetRef.Get(self.transmogContainer), CName("hideButton"))
	-- 			btnHideAppearanceCtrl[area] = btnHideAppearance[area]:GetControllerByType(CName("TransmogButtonView"))
	-- 		end

	-- 		isItemHidden = Mod:IsHidden(area)
	-- 		btnHideAppearanceCtrl[area]:SetActive(not isItemHidden)
	-- 	else
	-- 		if btnHideAppearance[area] ~= nil then
	-- 			inkCompoundRef.RemoveAllChildren(self.transmogContainer)
	-- 			btnHideAppearance[area] = nil
	-- 			btnHideAppearanceCtrl[area] = nil
	-- 		end
	-- 	end

	-- 	if not isEmpty and self.inventoryDataManager:IsSlotOverriden(area) then
	-- 		self.transmogItem = self.inventoryDataManager:GetVisualItemInSlot(area)
	-- 	else
	-- 		self.transmogItem = ItemID.FromTDBID("")
	-- 	end
	-- end)

	-- Override('InventoryItemDisplayController', 'OnDelayedHoverOver', function(self, proxy, wrapped)
	-- 	print("Hello")
	-- 	local area = self.equipmentArea
	-- 	local hoverOverEvent = ItemDisplayHoverOverEvent:new()
	-- 	hoverOverEvent.itemData = self:GetItemData()
  	-- 	hoverOverEvent.display = self
  	-- 	hoverOverEvent.widget = self.hoverTarget
  	-- 	hoverOverEvent.isBuybackStack = self.isBuybackStack
  	-- 	hoverOverEvent.transmogItem = self.transmogItem
  	-- 	hoverOverEvent.uiInventoryItem = self:GetUIInventoryItem()
  	-- 	hoverOverEvent.displayContextData = self.displayContextData

	-- 	if btnHideAppearanceCtrl[area] ~= nil then
	-- 		hoverOverEvent.isItemHidden = not btnHideAppearanceCtrl[area].IsActive()
	-- 	end

	-- 	if self.hoverTarget == btnHideAppearance[area] and btnHideAppearance[area] ~= nil then
	-- 		print("There")
	-- 		hoverOverEvent.toggleVisibilityControll = true
	-- 	end

	-- 	self:QueueEvent(hoverOverEvent)
		
	-- 	local parentButton = self:GetParentButton()
	-- 	if (not parentButton:GetAutoUpdateWidgetState()) and (not hoverOverEvent.toggleVisibilityControll) then
	-- 		self:GetRootWidget():SetState(CName("Hover"))
	-- 	end

	-- 	if self.isNew then
	-- 		self:SetIsNew(false)
	-- 	end

	-- 	if self.isDLCNewItem then
	-- 		self:SetDLCNewIndicator(false)
    -- 		local DLCAddedHoverOverEvent = DLCAddedItemDisplayHoverOverEvent:new()
    -- 		DLCAddedHoverOverEvent.itemTDBID = ItemID.GetTDBID(self:GetItemID())
    -- 		self:QueueEvent(DLCAddedHoverOverEvent)
	-- 	end

	-- 	self.delayProxy = nil
	-- end)

	-- Override('InventoryItemDisplayController', 'OnDisplayClicked', function(self, evt, wrapped)
	-- 	local area = self.equipmentArea
	-- 	local clickEvent = ItemDisplayClickEvent:new()
	-- 	clickEvent.itemData = self:GetItemData()
  	-- 	clickEvent.actionName = evt:GetActionName()
  	-- 	clickEvent.displayContext = self.itemDisplayContext
  	-- 	clickEvent.isBuybackStack = self.isBuybackStack
  	-- 	clickEvent.transmogItem = self.transmogItem
  	-- 	clickEvent.display = self
  	-- 	clickEvent.uiInventoryItem = self:GetUIInventoryItem()
  	-- 	clickEvent.displayContextData = self.displayContextData

	-- 	if evt:GetTarget() == btnHideAppearance[area] and btnHideAppearance[area] ~= nil then
	-- 		print("Why")
	-- 		clickEvent.toggleVisibilityRequest = true
	-- 	end

	-- 	self:HandleLocalClick(evt)
	-- 	self:QueueEvent(clickEvent)
	-- end)

	-- Override('InventoryItemModeLogicController', 'OnItemDisplayClick', function(self, evt, wrapped)
	-- 	if evt.toggleVisibilityRequest then
	-- 		if evt.actionName:IsAction(CName("click")) then
	-- 			Mod:Toggle(InventoryItemData.GetEquipmentArea(evt.itemData), nativeSettings, settingsTables)
	-- 			self.PlaySound(CName("Item"), CName("ItemGeneric"))
	-- 		end
	-- 	else
	-- 		wrapped(evt)
	-- 	end
	-- end)
	
	-- Mod handling
	GameUI.Observe(GameUI.Event.LoadingFinish, function()
		if not Mod.Ready and Game.GetPlayer() ~= nil then
			Mod:Setup(true)
		end
	end)

	GameUI.Observe(GameUI.Event.SessionStart, function()
		Cron.After(2.7, function()
			if not Mod.Ready and Game.GetPlayer() ~= nil then
				Mod:Setup(false)
			end
		end)
	end)

	GameUI.Observe(GameUI.Event.SessionEnd, function()
		Mod:Destroy()
	end)

	GameUI.Observe(GameUI.Event.SceneEnter, function()
		Cron.After(0.6, function()
			if not Mod.Ready and Game.GetPlayer() ~= nil then
				Mod:Setup(false)
			end
		end)
	end)

	GameUI.Observe(GameUI.Event.SceneExit, function()
		Cron.After(0.7, function()
			if Mod.Ready and Game.GetPlayer() ~= nil then
				Mod:Setup(false)
			end
		end)
	end)

	-- Mirrors character edit
	Observe('MenuScenario_CharacterCustomizationMirror', 'OnAccept', function()
		local self = Mod
		if not self.Ready then return end

		Cron.After(0.6, function()
			self:LoadClothes()
		end)
	end)
end)

registerForEvent('onUpdate', function(delta)
	-- This is required for Cron to function
	Cron.Update(delta)
end)

-- Hotkeys
registerHotkey('hide_armor_head', 'Toggle Head', function()
	Mod:Toggle('Head', nativeSettings, settingsTables)
end)

registerHotkey('hide_armor_face', 'Toggle Face', function()
	Mod:Toggle('Face', nativeSettings, settingsTables)
end)

registerHotkey('hide_armor_outer_chest', 'Toggle Outer Chest', function()
	Mod:Toggle('OuterChest', nativeSettings, settingsTables)
end)

registerHotkey('hide_armor_inner_chest', 'Toggle Inner Chest', function()
	Mod:Toggle('InnerChest', nativeSettings, settingsTables)
end)

registerHotkey('hide_armor_pants', 'Toggle Pants', function()
	Mod:Toggle('Legs', nativeSettings, settingsTables)
end)

registerHotkey('hide_armor_boots', 'Toggle Boots', function()
	Mod:Toggle('Feet', nativeSettings, settingsTables)
end)

registerHotkey('enable_ui', 'Toggle Inventory UI', function()
	local state = Mod:GetPreference('Inventory') == 1

	if enableNativeUI and nativeSettings and settingsTables['Inventory'] then
		nativeSettings.setOption(settingsTables['Inventory'], not state)
	elseif state then
		Mod:SetPreference('Inventory', 0)
	else
		Mod:SetPreference('Inventory', 1)
	end
end)

registerHotkey('fix_buttons', 'Fix In Game buttons', function()
	if Mod.Ready then
		Mod.Equipment:SetHeadSlotVisibility(false)
		Mod.Equipment:SetFaceSlotVisibility(false)
	end
end)
