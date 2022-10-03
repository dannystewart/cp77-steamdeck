import CustomQuickslotsConfig.*

@wrapMethod(GenericHotkeyController)
private final func InitializeButtonHint() -> Void {
  let hotkeyItemController: wref<HotkeyItemController> = this as HotkeyItemController;
  if IsDefined(hotkeyItemController) && hotkeyItemController.IsCustomHotkey() {
    if hotkeyItemController.GetLastUsedKBM() {
      // undo any previous settings
      this.m_buttonHintController.SetHoldIndicatorType(inkInputHintHoldIndicationType.Press);
      this.m_buttonHintController.SetInputAction(n"None");
      
      // get key (e.g. n"IK_5")
      let enumValue: Int32 = Cast(EnumValueFromName(n"EInputKey", hotkeyItemController.GetCustomHotkeyKeyboardInput()));
      let key: EInputKey = IntEnum(enumValue);
      
      // set the key on the button hint
      let data: inkInputKeyData;
      inkInputKeyData.SetInputKey(data, key);
      inkInputKeyData.SetIsHoldInput(data, false);
      this.m_buttonHintController.SetInputKey(data);
    }
    else {
      if hotkeyItemController.IsGamepadHoldModifierHeld() {
        this.m_buttonHintController.SetInputAction(hotkeyItemController.GetCustomHotkeyGamepadInput());
        this.m_buttonHintController.SetHoldIndicatorType(inkInputHintHoldIndicationType.Press);
      } else {
        this.m_buttonHintController.SetInputAction(hotkeyItemController.GetCustomHotkeyGamepadHoldModifier());
        this.m_buttonHintController.SetHoldIndicatorType(inkInputHintHoldIndicationType.Hold);
      }
    }
    return;
  }
  wrappedMethod();
}

@addField(HotkeyItemController)
private let m_customHotkeyIsGrenade: Bool;

@addField(HotkeyItemController)
private let m_isConsumable: Bool;

@addField(HotkeyItemController)
private let m_isCustomHotkey: Bool;

@addField(HotkeyItemController)
private let m_customHotkeyIsGamepadHoldModifierHeld: Bool;

@addField(HotkeyItemController)
private let m_lastUsedKBM: Bool;

@addField(HotkeyItemController)
private let m_customQuickslotProperties: ref<CustomQuickslot>;

@addField(HotkeyItemController)
public let customQuickSlotIndex: Int32;

@addMethod(HotkeyItemController)
public func IsCustomHotkey() -> Bool {
  return this.m_isCustomHotkey;
}

@addMethod(HotkeyItemController)
public func IsCustomCyberwareAbility() -> Bool {
  switch this.m_customQuickslotProperties.itemType {
    case CustomQuickslotItemType.BloodPump:
    case CustomQuickslotItemType.OpticalCamo:
      return true;
    default:
      return false;
  }
  return false;
}

@addMethod(HotkeyItemController)
public func IsCustomCyberwareWeapon() -> Bool {
  switch this.m_customQuickslotProperties.itemType {
    case CustomQuickslotItemType.ProjectileLauncher:
      return true;
    default:
      return false;
  }
}

@addMethod(HotkeyItemController)
public func GetCustomHotkeyKeyboardInput() -> CName {
  return this.m_customQuickslotProperties.keyboardInput;
}

@addMethod(HotkeyItemController)
public func GetCustomHotkeyGamepadInput() -> CName {
  return this.m_customQuickslotProperties.gamepadInput;
}

@addMethod(HotkeyItemController)
public func GetCustomHotkeyGamepadHoldModifier() -> CName {
  return this.m_customQuickslotProperties.gamepadHoldModifier;
}

@addMethod(HotkeyItemController)
public func IsGamepadHoldModifierHeld() -> Bool {
  return this.m_customHotkeyIsGamepadHoldModifierHeld;
}

@addMethod(HotkeyItemController)
public func GetLastUsedKBM() -> Bool {
  return this.m_lastUsedKBM;
}

// Lua module overrides these functions - bodies are just to silence linter
@addMethod(HotkeyItemController)
private func GetCustomQuickslots(slotNumber: Int32) -> array<ref<CustomQuickslot>> { return []; }

@addMethod(HotkeyItemController)
private func HideEmptyConsumableSlots() -> Bool { return false;}

@addMethod(HotkeyItemController)
private func HideEmptyCyberwareAbilitySlots() -> Bool { return false; }

@addMethod(HotkeyItemController)
private func IsE3HudCompatibilityMode() -> Bool { return false; }

@addMethod(HotkeyItemController)
private func InitializeCustomHotkeyType() -> Void {
  let widgetName: String = NameToString(this.GetRootWidget().GetName());
  let numString: String = StrAfterFirst(widgetName, "_");
  let index: Int32 = StringToInt(numString, -1);

  if index == -1 {
    this.m_isCustomHotkey = false;
    return;
  }
  this.m_isCustomHotkey = true;
  this.GetRootWidget().SetAffectsLayoutWhenHidden(false);

  let quickslots: array<ref<CustomQuickslot>> = this.GetCustomQuickslots(index);
  this.m_customQuickslotProperties = quickslots[index];
  this.customQuickSlotIndex = index;

  switch this.m_customQuickslotProperties.itemType {
    case CustomQuickslotItemType.Food:
    case CustomQuickslotItemType.Drink:
    case CustomQuickslotItemType.Alcohol:
    case CustomQuickslotItemType.HealthBooster:
    case CustomQuickslotItemType.StaminaBooster:
    case CustomQuickslotItemType.MemoryBooster:
    case CustomQuickslotItemType.CarryCapacityBooster:
    case CustomQuickslotItemType.OxyBooster:
    case CustomQuickslotItemType.MaxDoc:
    case CustomQuickslotItemType.BounceBack:
    case CustomQuickslotItemType.RainbowPoppers:
    case CustomQuickslotItemType.Glitter:
    case CustomQuickslotItemType.FR3SH:
    case CustomQuickslotItemType.SecondWind:
    case CustomQuickslotItemType.Locus:
    case CustomQuickslotItemType.EVade:
    case CustomQuickslotItemType.BeRiteBack:
    case CustomQuickslotItemType.Juice:
    case CustomQuickslotItemType.Rara:
    case CustomQuickslotItemType.Ullr:
    case CustomQuickslotItemType.ArasakaReflexBooster:
    case CustomQuickslotItemType.PurpleHaze:
    case CustomQuickslotItemType.BlackLace:
    case CustomQuickslotItemType.Donner:
    case CustomQuickslotItemType.IC3C0LD:
    case CustomQuickslotItemType.SyntheticBlood:
    case CustomQuickslotItemType.RoaringPhoenix:
    case CustomQuickslotItemType.Cleanser:
    case CustomQuickslotItemType.GrisGris:
    case CustomQuickslotItemType.Superjet:
    case CustomQuickslotItemType.Brisky:
    case CustomQuickslotItemType.Deimos:
    case CustomQuickslotItemType.Aspis:
    case CustomQuickslotItemType.Karanos:
      this.m_isConsumable = true;
      break;
    case CustomQuickslotItemType.BiohazardGrenade:
    case CustomQuickslotItemType.CuttingGrenade:
    case CustomQuickslotItemType.EMPGrenade:
    case CustomQuickslotItemType.FlashGrenade:
    case CustomQuickslotItemType.FragGrenade:
    case CustomQuickslotItemType.IncendiaryGrenade:
    case CustomQuickslotItemType.OzobsNose:
    case CustomQuickslotItemType.ReconGrenade:
      this.m_customHotkeyIsGrenade = true;
      break;
    default:
      break;
  }
}

@addMethod(HotkeyItemController)
private func ChangeHotkeyAppearenceForE3HUD() -> Void {
  let root: ref<inkCompoundWidget> = this.GetRootWidget() as inkCompoundWidget;
  let fg: ref<inkImage>;
  let bg: ref<inkImage>;
  let bgGlow: ref<inkImage>;
  let clickedDown: ref<inkImage>;

  if Equals(this.m_hotkey, EHotkey.DPAD_UP) {
    fg = root.GetWidget(n"wrapper_Dpad_Up/item_wrapper_Dpad_Up/fg") as inkImage;
    bg = root.GetWidget(n"wrapper_Dpad_Up/item_wrapper_Dpad_Up/BGG") as inkImage;
    bgGlow = root.GetWidget(n"wrapper_Dpad_Up/item_wrapper_Dpad_Up/onUseGlow/dpadUp_bg_glow") as inkImage;
    clickedDown = root.GetWidget(n"wrapper_Dpad_Up/item_wrapper_Dpad_Up/onUseGlow/dpadUp_bg_clicked") as inkImage;
  }
  else {
    fg = root.GetWidget(n"wrapper_RB/item_wrapper/fg") as inkImage;
    bg = root.GetWidget(n"wrapper_RB/item_wrapper/bg") as inkImage;
    bgGlow = root.GetWidget(n"wrapper_RB/item_wrapper/RB_bg_glow") as inkImage;
    clickedDown = root.GetWidget(n"wrapper_RB/item_wrapper/onUse/RB_bg_clicked") as inkImage;
  }

  fg.SetAtlasResource(r"base\\gameplay\\gui\\common\\icons\\atlas_common.inkatlas");
  fg.SetTexturePart(n"cell_rounded_fg");
  fg.SetTintColor(new HDRColor(0.949, 0.241, 0.454, 1.0));
  bg.SetAtlasResource(r"base\\gameplay\\gui\\common\\icons\\atlas_common.inkatlas");
  bg.SetTexturePart(n"cell_rounded_bg");
  bgGlow.SetAtlasResource(r"base\\gameplay\\gui\\common\\icons\\atlas_common.inkatlas");
  bgGlow.SetTexturePart(n"cell_rounded_bg");
  clickedDown.SetAtlasResource(r"base\\gameplay\\gui\\common\\icons\\atlas_common.inkatlas");
  clickedDown.SetTexturePart(n"cell_rounded_bg");
}

@wrapMethod(HotkeyItemController)
protected func Initialize() -> Bool {
  this.InitializeCustomHotkeyType();
  this.m_lastUsedKBM = true;
  this.m_customHotkeyIsGamepadHoldModifierHeld = false;
  let val: Bool = wrappedMethod();

  // needed for after slots are created when number of slots changed in menu
  if this.IsE3HudCompatibilityMode() {
    this.ChangeHotkeyAppearenceForE3HUD();
  }

  if Equals(this.m_hotkey, EHotkey.DPAD_UP) {
    if !this.IsCustomHotkey() {
      ArrayPush(this.m_restrictions, n"NoCombat");
      return val;
    }

    switch this.m_customQuickslotProperties.itemType {
      case CustomQuickslotItemType.MaxDoc:
      case CustomQuickslotItemType.BounceBack:
      case CustomQuickslotItemType.RainbowPoppers:
      case CustomQuickslotItemType.Glitter:
      case CustomQuickslotItemType.FR3SH:
      case CustomQuickslotItemType.SecondWind:
      case CustomQuickslotItemType.Locus:
      case CustomQuickslotItemType.EVade:
      case CustomQuickslotItemType.BeRiteBack:
      case CustomQuickslotItemType.Juice:
      case CustomQuickslotItemType.Rara:
      case CustomQuickslotItemType.Ullr:
      case CustomQuickslotItemType.ArasakaReflexBooster:
      case CustomQuickslotItemType.PurpleHaze:
      case CustomQuickslotItemType.BlackLace:
      case CustomQuickslotItemType.Donner:
      case CustomQuickslotItemType.IC3C0LD:
      case CustomQuickslotItemType.SyntheticBlood:
      case CustomQuickslotItemType.RoaringPhoenix:
      case CustomQuickslotItemType.Cleanser:
      case CustomQuickslotItemType.GrisGris:
      case CustomQuickslotItemType.Superjet:
      case CustomQuickslotItemType.Brisky:
      case CustomQuickslotItemType.Deimos:
      case CustomQuickslotItemType.Aspis:
      case CustomQuickslotItemType.Karanos:
        ArrayPush(this.m_restrictions, n"NoCombat");
        break;
      default:
        break;
    }
  }
  return val;
}

@wrapMethod(HotkeyItemController)
protected func Uninitialize() -> Void {
  if this.IsCustomHotkey() {
    this.GetPlayer().UnregisterInputListener(this);
  }
  wrappedMethod();
}

@wrapMethod(HotkeyItemController)
private final func InitializeHotkeyItem() -> Void {
  if !this.IsCustomHotkey() {
    wrappedMethod();
  }
}

@wrapMethod(HotkeyItemController)
protected cb func OnPlayerAttach(playerPuppet: ref<GameObject>) -> Bool {
  if this.IsCustomHotkey() {
    playerPuppet as PlayerPuppet.RegisterInputListener(this);
    
    if this.IsCustomCyberwareAbility() || this.IsCustomCyberwareWeapon() {
      this.CustomHotkeyInitializeCyberwareItem();
    }
    else {
      this.getNewItem();
    }
  }
  wrappedMethod(playerPuppet);
}

@addMethod(HotkeyItemController)
public func getNewItem() -> Void {
  let item: ItemID;
  if this.m_customHotkeyIsGrenade {
    if this.m_customQuickslotProperties.grenadeCycle {
      if this.HasEmptyItem() {
        item = this.GetPlayer().m_customHotkeysConsumablesInventory.GetGrenadeWithPreferredQuality(this.m_customQuickslotProperties.itemType, this.m_customQuickslotProperties.grenadeQuality);
      }
      else {
        item = this.GetPlayer().m_customHotkeysConsumablesInventory.CycleGrenade(this.m_customQuickslotProperties.itemType, this.m_currentItem.ID, true);
      }
    }
    else {
      item = this.GetPlayer().m_customHotkeysConsumablesInventory.GetGrenadeWithPreferredQuality(this.m_customQuickslotProperties.itemType, this.m_customQuickslotProperties.grenadeQuality);
    }
  }
  else {
    item = this.GetPlayer().m_customHotkeysConsumablesInventory.GetNewItem(this.m_customQuickslotProperties.itemType);
  }
  
  let newInventoryItemData: InventoryItemData = this.m_inventoryManager.GetItemDataFromIDInLoadout(item);
  
  this.m_currentItem = newInventoryItemData;
  this.m_hotkeyItemController.Setup(this.m_currentItem, ItemDisplayContext.DPAD_RADIAL);
  
  if this.HideEmptyConsumableSlots() {
    if InventoryItemData.IsEmpty(newInventoryItemData) {
      this.SetVisibilityAndNotifyHotkeysController(false);
    }
    else {
      this.SetVisibilityAndNotifyHotkeysController(true);
    }
  }
}

@addMethod(HotkeyItemController)
public func updateCurrentItem() -> Void {
  this.m_currentItem = this.m_inventoryManager.GetItemDataFromIDInLoadout(this.m_currentItem.ID);
  this.m_hotkeyItemController.Setup(this.m_currentItem, ItemDisplayContext.DPAD_RADIAL);
}

@addMethod(HotkeyItemController)
public func HotkeyReleased() -> Void {
  if this.IsInDefaultState() {
    this.UseEquippedItem();
  }
  else {
      this.PlayLibraryAnimation(n"started_RB");
  }
}

@addMethod(HotkeyItemController)
protected cb func OnAction(action: ListenerAction, consumer: ListenerActionConsumer) -> Bool {
  if !this.IsCustomHotkey() {
    return false;
  }

  if this.m_lastUsedKBM {
    if !this.GetPlayer().PlayerLastUsedKBM() {
      this.m_lastUsedKBM = false;
      this.InitializeButtonHint();
    }
  }
  else {
    if this.GetPlayer().PlayerLastUsedKBM() {
      this.m_lastUsedKBM = true;
      this.InitializeButtonHint();
    }
  }

  let actionName: CName = ListenerAction.GetName(action);
  let actionType: gameinputActionType = ListenerAction.GetType(action);

  if Equals(actionType, gameinputActionType.BUTTON_HOLD_COMPLETE) && Equals(actionName, this.m_customQuickslotProperties.gamepadHoldModifier) {
    if !this.m_customHotkeyIsGamepadHoldModifierHeld {
      this.m_customHotkeyIsGamepadHoldModifierHeld = true;
      this.InitializeButtonHint();
    }
  }

  if !Equals(actionType, gameinputActionType.BUTTON_RELEASED) {
    return false;
  }

  if Equals(actionName, this.m_customQuickslotProperties.gamepadHoldModifier) ||
  (Equals(this.m_customQuickslotProperties.gamepadHoldModifier, n"DropCarriedObject") && Equals(actionName, n"click")) {
    if this.m_customHotkeyIsGamepadHoldModifierHeld {
      this.m_customHotkeyIsGamepadHoldModifierHeld = false;
      this.InitializeButtonHint();
    }
  }

  if this.GetPlayer().PlayerLastUsedKBM() {
    return false;
  } 
  
  if !Equals(actionName, this.m_customQuickslotProperties.gamepadInput) || !this.m_customHotkeyIsGamepadHoldModifierHeld {
    return false;
  }

  if !this.IsInDefaultState() {
    this.PlayLibraryAnimation(n"started_RB");
    return false;
  }
  
  this.UseEquippedItem();
}

@addMethod(HotkeyItemController)
private func UseEquippedItem() -> Void {
  switch this.m_customQuickslotProperties.itemType {
    case CustomQuickslotItemType.Food:
      if !this.IsUsingItemRestricted() && !this.HasEmptyItem() {
        this.PlayLibraryAnimation(n"onUse_DPAD_UP");
        GameObject.PlaySoundEvent(this.GetPlayer(), n"ui_loot_eat");
        ItemActionsHelper.EatItem(this.GetPlayer(), this.m_currentItem.ID, false);
      }
      else {
        this.PlayLibraryAnimation(n"started_RB");
      }
      break;
    case CustomQuickslotItemType.Drink:
      if !this.IsUsingItemRestricted() && !this.HasEmptyItem() {
        this.PlayLibraryAnimation(n"onUse_DPAD_UP");
        GameObject.PlaySoundEvent(this.GetPlayer(), n"ui_loot_drink");
        ItemActionsHelper.DrinkItem(this.GetPlayer(), this.m_currentItem.ID, false);
      }
      else {
        this.PlayLibraryAnimation(n"started_RB");
      }
      break;
    case CustomQuickslotItemType.Alcohol:
      if !this.IsUsingItemRestricted() && !this.HasEmptyItem() {
        this.PlayLibraryAnimation(n"onUse_DPAD_UP");
        GameObject.PlaySoundEvent(this.GetPlayer(), n"ui_loot_drink");
        ItemActionsHelper.ConsumeItem(this.GetPlayer(), this.m_currentItem.ID, false);
      }
      else {
        this.PlayLibraryAnimation(n"started_RB");
      }
      break;
    case CustomQuickslotItemType.HealthBooster:
      if !this.IsUsingItemRestricted() && !this.HasEmptyItem() {
        this.PlayLibraryAnimation(n"onUse_DPAD_UP");
        GameObject.PlaySoundEvent(this.GetPlayer(), n"ui_menu_item_consumable_booster");
        ItemActionsHelper.ConsumeItem(this.GetPlayer(), this.m_currentItem.ID, false);
      }
      else {
        this.PlayLibraryAnimation(n"started_RB");
      }
      break;
    case CustomQuickslotItemType.StaminaBooster:
      if !this.IsUsingItemRestricted() && !this.HasEmptyItem() {
        this.PlayLibraryAnimation(n"onUse_DPAD_UP");
        GameObject.PlaySoundEvent(this.GetPlayer(), n"vfx_fullscreen_stamina_regen_activate");
        ItemActionsHelper.ConsumeItem(this.GetPlayer(), this.m_currentItem.ID, false);
      }
      else {
        this.PlayLibraryAnimation(n"started_RB");
      }
      break;
    case CustomQuickslotItemType.MemoryBooster:
      if !this.IsUsingItemRestricted() && !this.HasEmptyItem() {
        this.PlayLibraryAnimation(n"onUse_DPAD_UP");
        GameObject.PlaySoundEvent(this.GetPlayer(), n"vfx_fullscreen_memory_boost_activate");
        ItemActionsHelper.ConsumeItem(this.GetPlayer(), this.m_currentItem.ID, false);
      }
      else {
        this.PlayLibraryAnimation(n"started_RB");
      }
      break;
    case CustomQuickslotItemType.CarryCapacityBooster:
      if !this.IsUsingItemRestricted() && !this.HasEmptyItem() {
        this.PlayLibraryAnimation(n"onUse_DPAD_UP");
        GameObject.PlaySoundEvent(this.GetPlayer(), n"vfx_fullscreen_memory_boost_deactivate");
        ItemActionsHelper.ConsumeItem(this.GetPlayer(), this.m_currentItem.ID, false);
      }
      else {
        this.PlayLibraryAnimation(n"started_RB");
      }
      break;
    case CustomQuickslotItemType.OxyBooster:
      if !this.IsUsingItemRestricted() && !this.HasEmptyItem() {
        this.PlayLibraryAnimation(n"onUse_DPAD_UP");
        GameObject.PlaySoundEvent(this.GetPlayer(), n"ui_menu_item_consumable_booster");
        ItemActionsHelper.ConsumeItem(this.GetPlayer(), this.m_currentItem.ID, false);
      }
      else {
        this.PlayLibraryAnimation(n"started_RB");
      }
      break;
    case CustomQuickslotItemType.BloodPump:
    case CustomQuickslotItemType.OpticalCamo:
      if !this.IsUsingItemRestricted() && !this.HasEmptyItem() {
        this.PlayLibraryAnimation(n"aborted_RB");
        this.PlayLibraryAnimation(n"onFailUse_RB");
        ItemActionsHelper.UseItem(this.GetPlayer(), this.m_currentItem.ID);
      }
      else {
        this.PlayLibraryAnimation(n"started_RB");
      }
      break;
    case CustomQuickslotItemType.MaxDoc:
    case CustomQuickslotItemType.BounceBack:
    case CustomQuickslotItemType.RainbowPoppers:
    case CustomQuickslotItemType.Glitter:
    case CustomQuickslotItemType.FR3SH:
    case CustomQuickslotItemType.SecondWind:
    case CustomQuickslotItemType.Locus:
    case CustomQuickslotItemType.EVade:
    case CustomQuickslotItemType.BeRiteBack:
    case CustomQuickslotItemType.Juice:
    case CustomQuickslotItemType.Rara:
    case CustomQuickslotItemType.Ullr:
    case CustomQuickslotItemType.ArasakaReflexBooster:
    case CustomQuickslotItemType.PurpleHaze:
    case CustomQuickslotItemType.BlackLace:
    case CustomQuickslotItemType.Donner:
    case CustomQuickslotItemType.IC3C0LD:
    case CustomQuickslotItemType.SyntheticBlood:
    case CustomQuickslotItemType.RoaringPhoenix:
    case CustomQuickslotItemType.Cleanser:
    case CustomQuickslotItemType.GrisGris:
    case CustomQuickslotItemType.Superjet:
    case CustomQuickslotItemType.Brisky:
    case CustomQuickslotItemType.Deimos:
    case CustomQuickslotItemType.Aspis:
    case CustomQuickslotItemType.Karanos:
      if !this.IsUsingItemRestricted() && this.IsAllowedByGameplay() && !this.HasEmptyItem() {
        let evt: ref<CustomHotkeyRequestUseHealingItem> = new CustomHotkeyRequestUseHealingItem();
        evt.quickslotIndex = this.customQuickSlotIndex;
        this.GetPlayer().QueueEvent(evt);
      }
      else {
        this.PlayLibraryAnimation(n"started_RB");
      }
      break;
    case CustomQuickslotItemType.BiohazardGrenade:
    case CustomQuickslotItemType.CuttingGrenade:
    case CustomQuickslotItemType.EMPGrenade:
    case CustomQuickslotItemType.FlashGrenade:
    case CustomQuickslotItemType.FragGrenade:
    case CustomQuickslotItemType.IncendiaryGrenade:
    case CustomQuickslotItemType.OzobsNose:
    case CustomQuickslotItemType.ReconGrenade:
      if !this.HasEmptyItem() {
        let playerData: wref<EquipmentSystemPlayerData> = EquipmentSystem.GetData(this.GetPlayer());
        let previousGadget: ItemID = playerData.GetItemIDfromEquipmentManipulationAction(EquipmentManipulationAction.RequestGadget);
        if ItemID.GetTDBID(this.m_currentItem.ID) != ItemID.GetTDBID(previousGadget) {
          this.PlayLibraryAnimation(n"onUse_DPAD_UP");
        }
        else {
          this.PlayLibraryAnimation(n"started_RB");
        }
        let request: ref<HotkeyAssignmentRequest> = HotkeyAssignmentRequest.Construct(this.m_currentItem.ID, EHotkey.RB, this.GetPlayer(), EHotkeyRequestType.Assign);
        if request.IsValid() {
          this.GetEquipmentSystem().QueueRequest(request);
        };
        if this.m_customQuickslotProperties.grenadeCycle {
          this.getNewItem();
        }
      }
      else {
        this.PlayLibraryAnimation(n"started_RB");
      }
      break;
    case CustomQuickslotItemType.ProjectileLauncher:
      if !this.HasEmptyItem() {
        let playerData: wref<EquipmentSystemPlayerData> = EquipmentSystem.GetData(this.GetPlayer());
        let previousGadget: ItemID = playerData.GetItemIDfromEquipmentManipulationAction(EquipmentManipulationAction.RequestGadget);
        if ItemID.GetTDBID(this.m_currentItem.ID) != ItemID.GetTDBID(previousGadget) {
          this.PlayLibraryAnimation(n"onUse_DPAD_UP");
        }
        else {
          this.PlayLibraryAnimation(n"started_RB");
        }
        let request: ref<HotkeyAssignmentRequest> = HotkeyAssignmentRequest.Construct(this.m_currentItem.ID, EHotkey.RB, this.GetPlayer(), EHotkeyRequestType.Assign);
        if request.IsValid() {
          this.GetEquipmentSystem().QueueRequest(request);
        }
      }
      else {
        this.PlayLibraryAnimation(n"started_RB");
      }
      break;
    default:
      break;
  }
  // GameObject.PlaySoundEvent(this.GetPlayer(), n"vfx_fullscreen_stamina_regen_deactivate");
}

// play the failed animation when request rejected
@addMethod(HotkeyItemController)
protected cb func OnCustomHotkeyRejectUseHealingItem(evt: ref<CustomHotkeyRejectUseHealingItem>) -> Bool {
  if evt.quickslotIndex != this.customQuickSlotIndex || !this.IsCustomHotkey() {
    return false;
  }
  this.PlayLibraryAnimation(n"started_RB");
}

@addMethod(HotkeyItemController)
protected cb func OnCustomHotkeyAllowUseHealingItem(evt: ref<CustomHotkeyAllowUseHealingItem>) -> Bool {
  if evt.quickslotIndex != this.customQuickSlotIndex || !this.IsCustomHotkey() {
    return false;
  }

  this.isInProgressConsumingHealingItem = true;

  // save previously equipped consumable
  let playerData: wref<EquipmentSystemPlayerData> = EquipmentSystem.GetData(this.GetPlayer());
  this.previousHealingItem = playerData.GetItemIDfromEquipmentManipulationAction(EquipmentManipulationAction.RequestConsumable);
  
  this.PlayLibraryAnimation(n"onUse_DPAD_UP");

  // change equipped consumable
  this.m_inventoryManager.EquipItem(this.m_currentItem.ID, 0);

  // use the equipped consumable
  let dpadAction: ref<DPADActionPerformed> = new DPADActionPerformed();
  dpadAction.action = EHotkey.DPAD_UP;
  dpadAction.successful = true;
  GameInstance.GetUISystem(this.GetPlayer().GetGame()).QueueEvent(dpadAction);
  let request: ref<EquipmentSystemWeaponManipulationRequest> = new EquipmentSystemWeaponManipulationRequest();
  request.owner = this.GetPlayer();
  request.requestType = EquipmentManipulationAction.RequestConsumable;
  this.m_equipmentSystem.QueueRequest(request);
}

@wrapMethod(EquipmentSystemPlayerData)
public final func OnSetActiveItemInEquipmentArea(request: ref<SetActiveItemInEquipmentArea>) -> Void {
  let slotIndex: Int32 = this.GetSlotIndex(request.itemID);
  let equipAreaIndex: Int32 = this.GetEquipAreaIndex(EquipmentSystem.GetEquipAreaTypeForDpad(request.itemID));
  let equipArea: SEquipArea = this.m_equipment.equipAreas[equipAreaIndex];
  if slotIndex >= 0 && slotIndex < ArraySize(equipArea.equipSlots) {
  }
  wrappedMethod(request);
}

@addField(HotkeyItemController)
private let previousHealingItem: ItemID;

@addField(HotkeyItemController)
private let isInProgressConsumingHealingItem: Bool;

@wrapMethod(HotkeyItemController)
protected func IsAllowedByGameplay() -> Bool {
  if this.IsCustomCyberwareAbility() {
    return !PlayerGameplayRestrictions.IsHotkeyRestricted(this.GetPlayer().GetGame(), EHotkey.RB);
  }
  if this.IsCustomHotkey() {
    switch this.m_customQuickslotProperties.itemType {
      case CustomQuickslotItemType.MaxDoc:
      case CustomQuickslotItemType.BounceBack:
      case CustomQuickslotItemType.RainbowPoppers:
      case CustomQuickslotItemType.Glitter:
      case CustomQuickslotItemType.FR3SH:
      case CustomQuickslotItemType.SecondWind:
      case CustomQuickslotItemType.Locus:
      case CustomQuickslotItemType.EVade:
      case CustomQuickslotItemType.BeRiteBack:
      case CustomQuickslotItemType.Juice:
      case CustomQuickslotItemType.Rara:
      case CustomQuickslotItemType.Ullr:
      case CustomQuickslotItemType.ArasakaReflexBooster:
      case CustomQuickslotItemType.PurpleHaze:
      case CustomQuickslotItemType.BlackLace:
      case CustomQuickslotItemType.Donner:
      case CustomQuickslotItemType.IC3C0LD:
      case CustomQuickslotItemType.SyntheticBlood:
      case CustomQuickslotItemType.RoaringPhoenix:
      case CustomQuickslotItemType.Cleanser:
      case CustomQuickslotItemType.GrisGris:
      case CustomQuickslotItemType.Superjet:
      case CustomQuickslotItemType.Brisky:
      case CustomQuickslotItemType.Deimos:
      case CustomQuickslotItemType.Aspis:
      case CustomQuickslotItemType.Karanos:
        return wrappedMethod();
      default:
        // covers all the same scenarios as injector/inhalers plus cyberspace, just to avoid conflic with FGR which uses "NoInhalerOrInjector" tag for inhaler cooldown.
        let tags: array<CName> = [n"Tier2Locomotion", n"BodyCarryingGeneric", n"FistFight", n"VehicleSummoning"];
        return !StatusEffectSystem.ObjectHasStatusEffectWithTags(this.GetPlayer(), tags);
    }
  }
  return wrappedMethod();
}

@addMethod(HotkeyItemController)
private func IsUsingItemRestricted() -> Bool {
  if !this.IsAllowedByGameplay() {
    return true;
  }
  let tier: Int32 = this.GetPlayer().GetPlayerStateMachineBlackboard().GetInt(GetAllBlackboardDefs().PlayerStateMachine.HighLevel);
  if tier >= EnumInt(gamePSMHighLevel.SceneTier3) && tier <= EnumInt(gamePSMHighLevel.SceneTier5) {
    return true;
  };
  // carrying body
  if this.GetPlayer().GetPlayerStateMachineBlackboard().GetBool(GetAllBlackboardDefs().PlayerStateMachine.Carrying) {
    return true;
  };
  // focus mode
  if this.GetPlayer().GetPlayerStateMachineBlackboard().GetInt(GetAllBlackboardDefs().PlayerStateMachine.Vision) == EnumInt(gamePSMVision.Focus) {
    return true;
  };
  // performing melee attack
  if this.GetPlayer().GetPlayerStateMachineBlackboard().GetInt(GetAllBlackboardDefs().PlayerStateMachine.Melee) == EnumInt(gamePSMMelee.Attack) {
    return true;
  };
  // is in vehicle
  if this.GetPlayer().GetQuickSlotsManager().IsPlayerInVehicle() {
    return true;
  }
  // choice hubs active
  let interactonsBlackboard: ref<IBlackboard> = GameInstance.GetBlackboardSystem(this.GetPlayer().GetGame()).Get(GetAllBlackboardDefs().UIInteractions);
  let interactionData: ref<UIInteractionsDef> = GetAllBlackboardDefs().UIInteractions;
  let data: DialogChoiceHubs = FromVariant(interactonsBlackboard.GetVariant(interactionData.DialogChoiceHubs));
  if ArraySize(data.choiceHubs) > 0 {
    return true;
  }
  return false;
}

@addMethod(QuickSlotsManager)
public func IsPlayerInVehicle() -> Bool {
  return this.m_IsPlayerInCar;
}

// These animations are pretty messed up. Most of them don't exist and there's some weird behaviour when certain ones are called.
// Also most of these conditions never/rarely happen
// Modified so that all the hotkeys (inclduding the grenade and inhaler original ones) do animations whenever used.
@replaceMethod(HotkeyItemController)
protected cb func OnDpadActionPerformed(evt: ref<DPADActionPerformed>) -> Bool {
  if this.IsCustomHotkey() || (Equals(this.m_hotkey, EHotkey.DPAD_UP) && this.m_originalHotkeyOverride) {
    return false;
  }
  if Equals(this.m_hotkey, EHotkey.DPAD_UP) && this.GetPlayer().IsCustomHotkeyHealingInProgress() {
    return false;
  }
  if Equals(this.m_hotkey, EHotkey.DPAD_UP) && !this.GetPlayer().IsCustomHotkeyHealingInProgress() && this.IsAllowedByGameplay() {
  // if Equals(this.m_hotkey, EHotkey.DPAD_UP) && !this.GetPlayer().IsCustomHotkeyHealingInProgress() {
    // original healing hotkey about to use item
    this.isInProgressConsumingHealingItem = true;
    let evt: ref<CustomHotkeyRequestUseHealingItem> = new CustomHotkeyRequestUseHealingItem();
    evt.isOriginalHotkey = true;
    this.GetPlayer().QueueEvent(evt);
  }

  let animName: CName;
  if Equals(this.m_hotkey, evt.action) {
    if !this.IsInDefaultState() {
      if Equals(evt.action, EHotkey.DPAD_UP) {
        this.PlayLibraryAnimation(n"started_RB");
      }
      else {
        animName = StringToName("aborted_" + EnumValueToString("EHotkey", Cast(EnumInt(this.m_hotkey))));
        this.PlayLibraryAnimation(animName);
        animName = StringToName("onFailUse_" + EnumValueToString("EHotkey", Cast(EnumInt(this.m_hotkey))));
        this.PlayLibraryAnimation(animName);  
      }
      return false;
    };
    if Equals(evt.state, EUIActionState.STARTED) {
      animName = StringToName("started_" + EnumValueToString("EHotkey", Cast(EnumInt(this.m_hotkey))));
      this.PlayLibraryAnimation(animName);
    } else {
      if Equals(evt.state, EUIActionState.ABORTED) {
        animName = StringToName("aborted_" + EnumValueToString("EHotkey", Cast(EnumInt(this.m_hotkey))));
        this.PlayLibraryAnimation(animName);
      } else {
        if Equals(evt.state, EUIActionState.COMPLETED) || evt.successful {
          // animName = StringToName("onUse_" + EnumValueToString("EHotkey", Cast(EnumInt(this.m_hotkey))));
          // this.PlayLibraryAnimation(animName);
          if Equals(evt.action, EHotkey.RB) {
            this.PlayLibraryAnimation(n"aborted_RB");
            this.PlayLibraryAnimation(n"onFailUse_RB");
          }
          else {
            animName = StringToName("onUse_" + EnumValueToString("EHotkey", Cast(EnumInt(this.m_hotkey))));
            this.PlayLibraryAnimation(animName);
          }
        } else {
          if !evt.successful {
            if Equals(evt.action, EHotkey.DPAD_UP) {
              this.PlayLibraryAnimation(n"started_RB");
            }
            else {
              animName = StringToName("aborted_" + EnumValueToString("EHotkey", Cast(EnumInt(this.m_hotkey))));
              this.PlayLibraryAnimation(animName);
              animName = StringToName("onFailUse_" + EnumValueToString("EHotkey", Cast(EnumInt(this.m_hotkey))));
              this.PlayLibraryAnimation(animName);
            }
          };
        };
      };
    };
  };
}

@wrapMethod(HotkeyItemController)
protected cb func OnHotkeyRefreshed(value: Variant) -> Bool {
  if this.IsCustomHotkey() {
    return false;
  }

  let hotkey: EHotkey = FromVariant<EHotkey>(value);
  if Equals(this.m_hotkey, EHotkey.DPAD_UP) && Equals(this.m_hotkey, hotkey) && this.isInProgressConsumingHealingItem {
    // original healing hotkey is finishing.
    let evt: ref<CustomHotkeyRequestUseHealingItem> = new CustomHotkeyRequestUseHealingItem();
    evt.isOriginalHotkey = true;
    evt.completed = true;
    this.GetPlayer().QueueEvent(evt);
    this.isInProgressConsumingHealingItem = false;
  }

  return wrappedMethod(value);
}

@addMethod(HotkeyItemController)
public func HasEmptyItem() -> Bool {
  return InventoryItemData.IsEmpty(this.m_currentItem);
}

@addMethod(HotkeyItemController)
public func IsItemSameAsCurrentItem(id: TweakDBID) -> Bool {
  return ItemID.GetTDBID(this.m_currentItem.ID) == id;
}

@addMethod(HotkeyItemController)
protected cb func OnItemQuantityChanged(evt: ref<CustomHotkeyItemQuantityChangedEvent>) -> Bool {
  if !this.IsCustomHotkey() || this.IsCustomCyberwareAbility() || this.IsCustomCyberwareWeapon() {
    return false;
  }

  let tweakId: TweakDBID = ItemID.GetTDBID(evt.itemID);
  let total: Int32 = Cast(evt.total);

  if this.IsItemSameAsCurrentItem(tweakId) {
    // change to same item in this slot
    if this.isInProgressConsumingHealingItem && evt.diff == -1 {
      this.m_inventoryManager.EquipItem(this.previousHealingItem, 0);
      this.previousHealingItem = new ItemID();
      this.isInProgressConsumingHealingItem = false;
      
      let evt: ref<CustomHotkeyRequestUseHealingItem> = new CustomHotkeyRequestUseHealingItem();
      evt.quickslotIndex = this.customQuickSlotIndex;
      evt.completed = true;
      this.GetPlayer().QueueEvent(evt);
    }
    
    if total > 0 {
      this.updateCurrentItem();
    }
    else {
      this.getNewItem();
    }
    return false;
  } 
    
  if total <= 0 {
    return false;
  }

  // nonzero amount of item different from current one

  // Conusmable?
  let consumable: ref<ConsumableItem_Record> = TweakDBInterface.GetConsumableItemRecord(tweakId);
  if this.m_isConsumable {
    if !IsDefined(consumable) {
      return false;
    }
    
    if !this.GetPlayer().m_customHotkeysConsumablesInventory.ConsumableIdBelongsToType(tweakId, this.m_customQuickslotProperties.itemType) {
      return false;
    }

    if this.HasEmptyItem() {
      this.getNewItem();
      return false;
    }

    let currentQuality = this.GetPlayer().m_customHotkeysConsumablesInventory.GetItemQuality(this.m_currentItem.ID);
    let newQuality = this.GetPlayer().m_customHotkeysConsumablesInventory.GetItemQuality(evt.itemID);
    
    if newQuality > currentQuality {
      this.getNewItem();
    }
    return false;
  }

  // this slot must be grenade
  let grenade: ref<Grenade_Record> = TweakDBInterface.GetGrenadeRecord(tweakId);
  if !IsDefined(grenade) {
    return false;
  }
  if Equals(this.GetGrenadeItemTypeForItem(grenade), this.m_customQuickslotProperties.itemType) {
    if this.HasEmptyItem() {
      this.getNewItem();
      return false;
    }

    if this.m_customQuickslotProperties.grenadeCycle {
      // not the same item, but may need to update item to cycle to
      this.getNewItem();
    }
    else {
      // not cycling, just need to check if new item is the preferred one
      if Equals(this.GetPlayer().m_customHotkeysConsumablesInventory.GetItemQuality(evt.itemID), EnumInt(this.m_customQuickslotProperties.grenadeQuality)) {
        this.getNewItem();
      }
    }
  }
}

@addMethod(HotkeyItemController)
private func GetGrenadeItemTypeForItem(grenade: ref<Grenade_Record>) -> CustomQuickslotItemType {
  let path: CName = grenade.AppearanceResourceName();
  if Equals(path, n"Preset_Grenade_Biohazard_Default") {
    return CustomQuickslotItemType.BiohazardGrenade;
  }
  if Equals(path, n"Preset_Grenade_Cutting_Default") {
    return CustomQuickslotItemType.CuttingGrenade;
  }
  if Equals(path, n"Preset_Grenade_EMP_Default") {
    return CustomQuickslotItemType.EMPGrenade;
  }
  if Equals(path, n"Preset_Grenade_Flash_Default") {
    return CustomQuickslotItemType.FlashGrenade;
  }
  if Equals(path, n"Preset_Grenade_Frag_Default") {
    return CustomQuickslotItemType.FragGrenade;
  }
  if Equals(path, n"Preset_Grenade_Incendiary_Default") {
    return CustomQuickslotItemType.IncendiaryGrenade;
  }
  if Equals(path, n"Preset_Grenade_Frag_Ozob") {
    return CustomQuickslotItemType.OzobsNose;
  }
  if Equals(path, n"Preset_Grenade_Recon_Default") {
    return CustomQuickslotItemType.ReconGrenade;
  }
  return CustomQuickslotItemType.FragGrenade;
}

@addMethod(HotkeyItemController)
private func GetCyberwareTypeName(type: CustomQuickslotItemType) -> CName {
  switch type {
    case CustomQuickslotItemType.BloodPump:
      return n"BloodPump";
    case CustomQuickslotItemType.OpticalCamo:
      return n"OpticalCamo";
    case CustomQuickslotItemType.ProjectileLauncher:
      return n"ProjectileLauncher";
    default:
      return n"";
  }
}

@addMethod(HotkeyItemController)
private func GetCyberwareArea(type: CustomQuickslotItemType) -> gamedataEquipmentArea {
  switch type {
    case CustomQuickslotItemType.BloodPump:
      return gamedataEquipmentArea.CardiovascularSystemCW;
    case CustomQuickslotItemType.OpticalCamo:
      return gamedataEquipmentArea.IntegumentarySystemCW;
    case CustomQuickslotItemType.ProjectileLauncher:
      return gamedataEquipmentArea.ArmsCW;
    default:
      return gamedataEquipmentArea.Invalid;
  }
}

@addMethod(HotkeyItemController)
private func CustomHotkeyInitializeCyberwareItem() -> Void {
  let area: gamedataEquipmentArea = this.GetCyberwareArea(this.m_customQuickslotProperties.itemType);
  let cyberwareType: CName = this.GetCyberwareTypeName(this.m_customQuickslotProperties.itemType);
  
  let playerData: wref<EquipmentSystemPlayerData> = EquipmentSystem.GetData(this.GetPlayer());
  let equipArea: SEquipArea = playerData.GetEquipArea(area);

  this.m_hotkeyItemController.Setup(this.m_currentItem, ItemDisplayContext.DPAD_RADIAL);
  
  for slot in equipArea.equipSlots {
    if Equals(TweakDBInterface.GetCName(ItemID.GetTDBID(slot.itemID) + t".cyberwareType", n"None"), cyberwareType) {
      let newInventoryItemData: InventoryItemData = this.m_inventoryManager.GetItemDataFromIDInLoadout(slot.itemID);
      this.m_currentItem = newInventoryItemData;
      this.m_hotkeyItemController.Setup(this.m_currentItem, ItemDisplayContext.DPAD_RADIAL);
      return;
    }
  }
  if this.HideEmptyCyberwareAbilitySlots() && InventoryItemData.IsEmpty(this.m_currentItem) {
    this.SetVisibilityAndNotifyHotkeysController(false);
  }
}

@addMethod(HotkeyItemController)
protected cb func OnItemEquipped(evt: ref<CustomHotkeyEquipItemEvent>) -> Bool {
  if !(this.IsCustomCyberwareAbility() || this.IsCustomCyberwareWeapon()) {
    return false;
  }

  let cyberwareType: CName = this.GetCyberwareTypeName(this.m_customQuickslotProperties.itemType);
  
  if Equals(TweakDBInterface.GetCName(ItemID.GetTDBID(evt.itemID) + t".cyberwareType", n"None"), cyberwareType) {
    let newInventoryItemData: InventoryItemData = this.m_inventoryManager.GetItemDataFromIDInLoadout(evt.itemID);
    this.m_currentItem = newInventoryItemData;
    this.m_hotkeyItemController.Setup(this.m_currentItem, ItemDisplayContext.DPAD_RADIAL);
    this.SetVisibilityAndNotifyHotkeysController(true);
    return true;
  }
}

@addMethod(HotkeyItemController)
protected cb func OnItemUnequipped(evt: ref<CustomHotkeyUnequipItemEvent>) -> Bool {
  if !(this.IsCustomCyberwareAbility() || this.IsCustomCyberwareWeapon()) {
    return false;
  }

  let oldItem: TweakDBID = ItemID.GetTDBID(evt.itemID);
  if this.IsItemSameAsCurrentItem(oldItem) {
    let newInventoryItemData: InventoryItemData;
    this.m_currentItem = newInventoryItemData;
    this.m_hotkeyItemController.Setup(this.m_currentItem, ItemDisplayContext.DPAD_RADIAL);
    if this.HideEmptyCyberwareAbilitySlots() {
      this.SetVisibilityAndNotifyHotkeysController(false);
    }
  }
}

public class CustomHotkeyEquipItemEvent extends Event {
  public let itemID: ItemID;
}

public class CustomHotkeyUnequipItemEvent extends Event {
  public let itemID: ItemID;
}

@wrapMethod(EquipmentSystemPlayerData)
private final func EquipItem(itemID: ItemID, slotIndex: Int32, opt blockActiveSlotsUpdate: Bool, opt forceEquipWeapon: Bool) -> Void {
  let evt: ref<CustomHotkeyEquipItemEvent> = new CustomHotkeyEquipItemEvent();
  evt.itemID = itemID;
  this.m_owner as PlayerPuppet.QueueEvent(evt);
  
  wrappedMethod(itemID, slotIndex, blockActiveSlotsUpdate, forceEquipWeapon);
}

@wrapMethod(EquipmentSystemPlayerData)
private final func UnequipItem(equipAreaIndex: Int32, opt slotIndex: Int32) -> Void {
  let currentItem: ItemID = this.m_equipment.equipAreas[equipAreaIndex].equipSlots[slotIndex].itemID;
  
  let evt: ref<CustomHotkeyUnequipItemEvent> = new CustomHotkeyUnequipItemEvent();
  evt.itemID = currentItem;
  this.m_owner as PlayerPuppet.QueueEvent(evt);
  
  wrappedMethod(equipAreaIndex, slotIndex);
}

@addMethod(HotkeyItemController)
private func SetVisibilityAndNotifyHotkeysController(visible: Bool) {
  this.GetRootWidget().SetVisible(visible);
  if this.IsE3HudCompatibilityMode() {
    let evt: ref<HotkeyVisibilityUpdateEvent> = new HotkeyVisibilityUpdateEvent();
    this.GetPlayer().QueueEvent(evt);
  }
}

public class GadgetChangedEvent extends Event {
  public let newItem: ItemID;
  public let oldItem: ItemID;
}

@wrapMethod(EquipmentSystemPlayerData)
public final func AssignItemToHotkey(newID: ItemID, hotkey: EHotkey) -> Void {
  let oldItem: ItemID = this.m_hotkeys[EnumInt(hotkey)].GetItemID();
  if Equals(hotkey, EHotkey.RB) && newID != oldItem {
    let player: wref<PlayerPuppet> = this.m_owner as PlayerPuppet;
    if IsDefined(player) {
      let evt: ref<GadgetChangedEvent> = new GadgetChangedEvent();
      evt.newItem = newID;
      evt.oldItem = oldItem;
      player.QueueEvent(evt);
    }
  }
  
  wrappedMethod(newID, hotkey);
}

@addMethod(HotkeyItemController)
protected cb func OnGadgetChanged(evt: ref<GadgetChangedEvent>) -> Bool {
  if this.m_customHotkeyIsGrenade && this.m_customQuickslotProperties.grenadeCycle {
    let tweakId: TweakDBID = ItemID.GetTDBID(evt.oldItem);
    let grenade: ref<Grenade_Record> = TweakDBInterface.GetGrenadeRecord(tweakId);
    if !IsDefined(grenade) {
      return false;
    }
    if Equals(this.GetGrenadeItemTypeForItem(grenade), this.m_customQuickslotProperties.itemType) {
      let cycleFromOldItem: ItemID = this.GetPlayer().m_customHotkeysConsumablesInventory.CycleGrenade(this.m_customQuickslotProperties.itemType, evt.oldItem, true);
      if this.IsItemSameAsCurrentItem(ItemID.GetTDBID(cycleFromOldItem)) {
        let newInventoryItemData: InventoryItemData = this.m_inventoryManager.GetItemDataFromIDInLoadout(evt.oldItem);
  
        this.m_currentItem = newInventoryItemData;
        this.m_hotkeyItemController.Setup(this.m_currentItem, ItemDisplayContext.DPAD_RADIAL);
        
        if this.HideEmptyConsumableSlots() {
          if InventoryItemData.IsEmpty(newInventoryItemData) {
            this.SetVisibilityAndNotifyHotkeysController(false);
          }
          else {
            this.SetVisibilityAndNotifyHotkeysController(true);
          }
        }
      }
    }
  }
}

public class CustomHotkeyRequestUseHealingItem extends Event {
  public let quickslotIndex: Int32;
  public let completed: Bool;
  public let isOriginalHotkey: Bool;
}

public class CustomHotkeyAllowUseHealingItem extends Event {
  public let quickslotIndex: Int32;
}

public class CustomHotkeyRejectUseHealingItem extends Event {
  public let quickslotIndex: Int32;
}

// This seems to never get use (it's called but doesn't have an effect ultimately) in unmodded game, but because food/drink items have
// empty gamedataConsumableType which becomes Drug (because it's the first one), when they are consumed they can cause one of
// Scissors' drugs to be equipped in the X slot.
@replaceMethod(ConsumeAction)
private final func TryToEquipSameTypeConsumable() -> Void {
  return;
}