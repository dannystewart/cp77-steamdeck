local Cron = require('Cron')

local Class = {}
Class.__index = Class
Class.inventoryState = {}
Class.preferencesState = {}
Class.types = {'Head', 'Face', 'OuterChest', 'InnerChest', 'Legs', 'Feet'}
Class.tagToArea = {}

function Class:Init()
	local this = {
		Ready = false,
		Player = false,
		Equipment = false,
		Transaction = false,
		emptyItemID = nil,
        innerSlotTweakDB = nil,
        outerSlotTweakDB = nil,
        legsSlotTweakDB = nil,
	}

	db:exec[=[
		CREATE TABLE Visibility (ID INTEGER PRIMARY KEY, Name, Hidden);
		INSERT INTO Visibility VALUES(NULL, 'Head', 0);
		INSERT INTO Visibility VALUES(NULL, 'Face', 0);
		INSERT INTO Visibility VALUES(NULL, 'OuterChest', 0);
		INSERT INTO Visibility VALUES(NULL, 'InnerChest', 0);
		INSERT INTO Visibility VALUES(NULL, 'Legs', 0);
		INSERT INTO Visibility VALUES(NULL, 'Feet', 0);
	]=]

	db:exec[=[
		CREATE TABLE UserOptions (ID INTEGER PRIMARY KEY, Name, Value);
		INSERT INTO UserOptions VALUES(NULL, 'Inventory', 1);
	]=]

	self.tagToArea['hide_H1'] = 'Head'
	self.tagToArea['hide_F1'] = 'Face'
	self.tagToArea['hide_T2'] = 'OuterChest'
	self.tagToArea['hide_T1'] = 'InnerChest'
	self.tagToArea['hide_L1'] = 'Legs'
	self.tagToArea['hide_S1'] = 'Feet'

	self.emptyItemID = ItemID.FromTDBID("")

    self.innerSlotTweakDB = TweakDBID("AttachmentSlots.Splinter")
	self.outerSlotTweakDB = TweakDBID("AttachmentSlots.EyesCW")
	self.legsSlotTweakDB = TweakDBID("AttachmentSlots.SilverhandArm")

	-- Load
	for row in db:rows("SELECT Name, Hidden FROM Visibility") do
		if row[2] == 0 then
			self.inventoryState[row[1]] = false
		else
			self.inventoryState[row[1]] = true
		end
	end

	for row in db:rows("SELECT Name, Value FROM UserOptions") do
		self.preferencesState[row[1]] = row[2]
	end

	-- setmetatable(this, self)
	-- return this
end

function Class:Setup(wait)
	-- Bail Early
	if self.Ready then
		return true
	end

    if wait == nil then wait = true end

	-- PlayerSystem
	local GetPlayerSystem = Game.GetPlayerSystem()
	if not GetPlayerSystem then return false end

	-- player
	local GetPlayer = GetPlayerSystem:GetLocalPlayerMainGameObject()
	if not GetPlayer then return false end

	-- Transaction
	local GetTransactionSystem = Game.GetTransactionSystem()
	if not GetTransactionSystem then return false end

	-- Equipment
	local GetEquipmentSystem = Game.GetScriptableSystemsContainer():Get(CName.new('EquipmentSystem'))
	if not GetEquipmentSystem then return false end

	-- PlayerEquipmentData
	local GetPlayerEquipmentData = GetEquipmentSystem:GetPlayerData(GetPlayer)
	if not GetPlayerEquipmentData then return false end

	-- Vars
	self.Ready = true
	self.Player = GetPlayer
	self.Equipment = GetPlayerEquipmentData
	self.Transaction = GetTransactionSystem

	-- Potential fix
	self.Equipment.isHeadSlotHidden = false
	self.Equipment.isFaceSlotHidden = false

	-- Load
	if wait then
        Cron.After(0.7, function()
            self:LoadClothes()
        end)
    else
        self:LoadClothes()
    end

	return true
end

function Class:ResetClothes()
	for iter, elem in pairs(self.types) do
		if not self:GetBlockade(elem) then
			self:Switch(elem, false, true)
		end
	end
end

function Class:LoadClothes()
	for iter, elem in pairs(self.types) do
		if self:GetBlockade(elem) then
			self:Switch(elem, true, true)
		else
			self:Switch(elem, self:IsHidden(elem))
		end
	end
end

function Class:Destroy()
	self.Ready = false
	self.Player = false
	self.Equipment = false
	self.Transaction = false
end

function Class:IsHidden(Area)
	if self:IsCloth(Area) and self.inventoryState[Area] then
		return true
	end

	return false
end

function Class:IsCloth(Area)
	for iter, elem in pairs(self.types) do
		if elem == Area then
			return true
		end
	end

	return false
end

function Class:GetBlockade(Area)
	if not self.Ready then
		return false
	else
		local itemID = self.Equipment:GetActiveItem('Outfit')
		if itemID == self.emptyItemID then
			return false
		else
			local visualTagsTweakDB = self.Transaction:GetVisualTagsByItemID(itemID, self.Equipment.owner)
			for iter, elem in pairs(visualTagsTweakDB) do
				if self.tagToArea[elem.value] == Area then
					return true
				end
			end

			return false
		end
	end
end

function Class:RemoveItemFromSlots(First, Second)
	self.Transaction:RemoveItemFromSlot(self.Player, First, false, false, false)
	self.Transaction:RemoveItemFromSlot(self.Player, Second, false, false, false)
end

function Class:ReEquipItem(area)
	local itemID = self.Equipment:GetActiveItem(area)
	if itemID ~= self.emptyItemID then
		if not self.Transaction:HasItemInAnySlot(self.Player, itemID) then
			self.Equipment:EquipItem(itemID)
		end
	end
end

function Class:ReEquipVisuals(Item, Area)
	self.Equipment:UnequipVisuals(Area)
	self.Equipment:EquipVisuals(Item)
end

function Class:Paperdoll(areaType)
	local equipAreaIndex = self.Equipment:GetEquipAreaIndex(areaType)
	local visualSlotIndex = self.Equipment:GetVisualSlotIndex(areaType)
	self.Equipment.clothingVisualsInfo[visualSlotIndex + 1].visualItem = self.emptyItemID
	local placementSlot = self.Equipment:GetPlacementSlot(equipAreaIndex, 0)

	local paperdollEquipData = SPaperdollEquipData.new()
	paperdollEquipData.equipArea = self.Equipment.equipment.equipAreas[equipAreaIndex + 1]
	paperdollEquipData.equipped = false
	paperdollEquipData.placementSlot = placementSlot
	paperdollEquipData.slotIndex = 0

	self.Equipment:UpdateEquipmentUIBB(paperdollEquipData, true)
end

function Class:ShouldShowBreast(Equip)
	-- if self == nil or not self.Ready then return false end

	-- if self:GetBlockade('InnerChest') or self:GetBlockade('OuterChest') then
	-- 	return false
	-- end

	-- local customizationState = Game.GetCharacterCustomizationSystem():GetState()

	-- if customizationState:IsBodyGenderMale() then return false end

	-- local innerHidden = self:IsHidden('InnerChest') or self.Transaction:IsSlotEmpty(self.Player, TweakDBID("AttachmentSlots.Chest"))
	-- local outerHidden = self:IsHidden('OuterChest') or self.Transaction:IsSlotEmpty(self.Player, TweakDBID("AttachmentSlots.Torso"))

	-- if Equip == nil then
	-- 	return innerHidden and outerHidden
	-- elseif Equip == 1 then
	-- 	return self:IsHidden('InnerChest') and outerHidden
	-- elseif Equip == 2 then
	-- 	return innerHidden and self:IsHidden('OuterChest')
	-- end

	return false
end

function Class:ShouldShowGenitals()
	-- if self == nil or not self.Ready then return false end

	-- if self:GetBlockade('Legs') then return false end

	-- return self.Equipment:ShouldShowGenitals() and self:IsHidden('Legs')

	return false
end

function Class:Switch(Area, IsHidden, Silent)
	if not Silent then
		self.inventoryState[Area] = IsHidden

		if IsHidden then
			db:exec("UPDATE Visibility SET Hidden = 1  WHERE Name = '".. Area .."'")
		else
			db:exec("UPDATE Visibility SET Hidden = 0  WHERE Name = '".. Area .."'")
		end
	end

	if not self.Ready then return end

	if self:GetBlockade(Area) and not Silent then return end

	local itemID = self.Equipment:GetActiveItem(Area)
	if IsHidden and itemID ~= self.emptyItemID then
		if (Area == 'InnerChest' or Area == 'OuterChest') and self:ShouldShowBreast() then
			local innerItemID = self.Equipment:GetActiveItem('InnerChest')
			local outerItemID = self.Equipment:GetActiveItem('OuterChest')

			Cron.After(0.2, function()
				if innerItemID ~= self.emptyItemID and self:ShouldShowBreast(1) and not self.Transaction:HasItemInSlot(self.Player, self.innerSlotTweakDB, innerItemID) then
					self.Transaction:ChangeItemToSlot(self.Player, self.innerSlotTweakDB, innerItemID)
					self:Paperdoll('InnerChest')
				end
			end)

			Cron.After(0.4, function()
				if outerItemID ~= self.emptyItemID and self:ShouldShowBreast(2) and not self.Transaction:HasItemInSlot(self.Player, self.outerSlotTweakDB, outerItemID) then
					self.Transaction:ChangeItemToSlot(self.Player, self.outerSlotTweakDB, outerItemID)
					self:Paperdoll('OuterChest')
				end
			end)
		elseif Area == 'Legs' then
			self.Equipment:ClearItemAppearanceEvent(Area)

			Cron.After(0.3, function()
				if self:ShouldShowGenitals() and self.Transaction:IsSlotEmpty(self.Player, self.legsSlotTweakDB) then
					self.Transaction:ChangeItemToSlot(self.Player, self.legsSlotTweakDB, itemID)
					self:Paperdoll('Legs')
				end
			end)

			self.Equipment:ResetItemAppearanceEvent('UnderwearBottom')
		else
			self.Equipment:ClearItemAppearanceEvent(Area)
		end
	elseif itemID ~= self.emptyItemID then
		if Area == 'InnerChest' and self.Transaction:HasItemInSlot(self.Player, self.innerSlotTweakDB, itemID) then
			self.Equipment:ResetItemAppearance(self.Transaction, Area, true)

			self:RemoveItemFromSlots(self.innerSlotTweakDB, TweakDBID("AttachmentSlots.Chest"))
			self.Transaction:AddItemToSlot(self.Player, TweakDBID("AttachmentSlots.Chest"), itemID)

			self:ReEquipVisuals(itemID, Area)
		elseif Area == 'OuterChest' and self.Transaction:HasItemInSlot(self.Player, self.outerSlotTweakDB, itemID) then
			self.Equipment:ResetItemAppearance(self.Transaction, Area, true)

			self:RemoveItemFromSlots(self.outerSlotTweakDB, TweakDBID("AttachmentSlots.Torso"))
			self.Transaction:AddItemToSlot(self.Player, TweakDBID("AttachmentSlots.Torso"), itemID)

			self:ReEquipVisuals(itemID, Area)
		elseif Area == 'Legs' and self.Transaction:HasItemInSlot(self.Player, self.legsSlotTweakDB, itemID) then
			self.Equipment:ResetItemAppearance(self.Transaction, Area, true)

			self:RemoveItemFromSlots(self.legsSlotTweakDB, TweakDBID("AttachmentSlots.Legs"))
			self.Transaction:AddItemToSlot(self.Player, TweakDBID("AttachmentSlots.Legs"), itemID, true)

			self:ReEquipVisuals(itemID, Area)
		else
			self.Equipment:ResetItemAppearanceEvent(Area)
		end
	end
end

function Class:Toggle(area, nativeSettings, settingsTables)
	if nativeSettings and settingsTables[area] then
		nativeSettings.setOption(settingsTables[area], self:IsHidden(area))
	else
		self:Switch(area, not self:IsHidden(area))
	end
end

function Class:GetPreference(Name)
	if not self.preferencesState[Name] then
		return 0
	end

	return self.preferencesState[Name]
end

function Class:SetPreference(Name, Value)
	self.preferencesState[Name] = Value
	db:exec("INSERT INTO UserOptions VALUES(NULL, '" .. Name .. "', " .. Value .. ")")
	db:exec("UPDATE UserOptions SET Value = " .. Value .. "  WHERE Name = '" .. Name .. "'")
end

registerForEvent('onUpdate', function(delta)
	-- This is required for Cron to function
	Cron.Update(delta)
end)

return Class