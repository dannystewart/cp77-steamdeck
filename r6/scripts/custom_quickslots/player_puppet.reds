import CustomQuickslotsConfig.*

@addField(PlayerPuppet)
public let m_customHotkeysConsumablesInventory: wref<CustomHotkeysConsumablesInventory>;

@addField(PlayerPuppet)
private let m_customHotkeysTransactionSystem: wref<TransactionSystem>;

@addField(PlayerPuppet)
private let m_customHotkeysInventoryListener: wref<InventoryScriptListener>;

@addField(PlayerPuppet)
private let m_customHotkeysInventoryManager: ref<InventoryDataManagerV2>;

@wrapMethod(PlayerPuppet)
protected cb func OnGameAttached() -> Bool {
  wrappedMethod();

  let inventoryListenerCallback: ref<CustomHotkeysConsumablesInventory> = new CustomHotkeysConsumablesInventory();
  this.m_customHotkeysConsumablesInventory = inventoryListenerCallback;

  this.m_customHotkeysTransactionSystem = GameInstance.GetTransactionSystem(this.GetGame());
  this.m_customHotkeysInventoryListener = this.m_customHotkeysTransactionSystem.RegisterInventoryListener(this, inventoryListenerCallback);

  this.m_customHotkeyPlayerButtonData = new CustomHotkeyPlayerButtonData();
  this.m_customHotkeyPlayerButtonData.SetPlayer(this);
}

@wrapMethod(PlayerPuppet)
protected cb func OnDetach() -> Bool {
  this.m_customHotkeysConsumablesInventory = null;

  this.m_customHotkeysTransactionSystem.UnregisterInventoryListener(this, this.m_customHotkeysInventoryListener);
  this.m_customHotkeysInventoryListener = null;

  wrappedMethod();
}

@addMethod(PlayerPuppet)
public func CustomHotkeysSetupInventoryListerner() -> Void {
  this.m_customHotkeysInventoryManager = new InventoryDataManagerV2();
  this.m_customHotkeysInventoryManager.Initialize(this);
  
  let items: array<ItemID>;
  this.m_customHotkeysInventoryManager.MarkToRebuild();
  let itemTypes: array<gamedataItemType>;
  ArrayPush(itemTypes, gamedataItemType.Con_Edible);
  ArrayPush(itemTypes, gamedataItemType.Con_LongLasting);
  ArrayPush(itemTypes, gamedataItemType.Con_Inhaler);
  ArrayPush(itemTypes, gamedataItemType.Con_Injector);
  ArrayPush(itemTypes, gamedataItemType.Gad_Grenade);
  this.m_customHotkeysInventoryManager.GetPlayerItemsIDsByTypes(itemTypes, items);

  this.m_customHotkeysConsumablesInventory.Setup(this, items); 
}

@wrapMethod(EquipmentSystem)
private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void {
  wrappedMethod(request);

  let player: wref<PlayerPuppet> = request.owner as PlayerPuppet;
  if IsDefined(player) {
    player.CustomHotkeysSetupInventoryListerner();
  }
}

@addField(PlayerPuppet)
private let customHotkeyHealingItemRequestIndex: Int32;

@addField(PlayerPuppet)
private let customHotkeyHealingItemRequestInProgress: Bool;

@addField(PlayerPuppet)
private let originalHotkeyHealingItemRequestInProgress: Bool;

@addMethod(PlayerPuppet)
protected cb func OnCustomHotkeyRequestUseHealingItem(evt: ref<CustomHotkeyRequestUseHealingItem>) -> Bool {
  if evt.isOriginalHotkey {
    this.originalHotkeyHealingItemRequestInProgress = !evt.completed;
    // LogChannel(n"DEBUG", s"Request: \(evt.isOriginalHotkey ? "Original" : "Custom"), \(evt.quickslotIndex), \(evt.completed ? "completed" : "starting"). originalInProgress: \(this.originalHotkeyHealingItemRequestInProgress), customInProgress: \(this.customHotkeyHealingItemRequestInProgress)");
    return false;
  }
  
  if evt.completed {
    this.customHotkeyHealingItemRequestInProgress = false;
    // LogChannel(n"DEBUG", s"Request: \(evt.isOriginalHotkey ? "Original" : "Custom"), \(evt.quickslotIndex), \(evt.completed ? "completed" : "starting"). originalInProgress: \(this.originalHotkeyHealingItemRequestInProgress), customInProgress: \(this.customHotkeyHealingItemRequestInProgress)");
    return false;
  }
  // if a request has been allowed and is not completed, we discard any other requests
  if !this.customHotkeyHealingItemRequestInProgress && !this.originalHotkeyHealingItemRequestInProgress {
    this.customHotkeyHealingItemRequestInProgress = true;
    let allowEvt: ref<CustomHotkeyAllowUseHealingItem> = new CustomHotkeyAllowUseHealingItem();
    allowEvt.quickslotIndex = evt.quickslotIndex;
    this.QueueEvent(allowEvt);
    // LogChannel(n"DEBUG", s"Request: \(evt.isOriginalHotkey ? "Original" : "Custom"), \(evt.quickslotIndex), \(evt.completed ? "completed" : "starting"). originalInProgress: \(this.originalHotkeyHealingItemRequestInProgress), customInProgress: \(this.customHotkeyHealingItemRequestInProgress)");
    return false;
  }
  let rejectEvt: ref<CustomHotkeyRejectUseHealingItem> = new CustomHotkeyRejectUseHealingItem();
  rejectEvt.quickslotIndex = evt.quickslotIndex;
  this.QueueEvent(rejectEvt);
  // LogChannel(n"DEBUG", s"REJECTED Request: \(evt.isOriginalHotkey ? "Original" : "Custom"), \(evt.quickslotIndex), \(evt.completed ? "completed" : "starting"). originalInProgress: \(this.originalHotkeyHealingItemRequestInProgress), customInProgress: \(this.customHotkeyHealingItemRequestInProgress)");
}

@addMethod(PlayerPuppet)
public func IsOriginalHotkeyHealingInProgress() -> Bool {
  return this.originalHotkeyHealingItemRequestInProgress;
}

@addMethod(PlayerPuppet)
public func IsCustomHotkeyHealingInProgress() -> Bool {
  return this.customHotkeyHealingItemRequestInProgress;
}

public class CustomHotkeyPlayerButtonData {
  private let player: wref<PlayerPuppet>;
  
  private let crouchHeld: Bool;
  private let dropBodyHeld: Bool;
  private let quickMeleeHeld: Bool;

  private let modifiersForDpadLeft: array<CName>;
  private let modifiersForDpadRight: array<CName>;
  private let modifiersForDpadUp: array<CName>;
  private let modifiersForDpadDown: array<CName>;

  public func ObserveAction(action: ListenerAction) -> Void {
    let actionName: CName = ListenerAction.GetName(action);
    let actionType: gameinputActionType = ListenerAction.GetType(action);  
    
    let shouldSendEvent: Bool = false;
    if Equals(actionType, gameinputActionType.BUTTON_HOLD_COMPLETE) {  
      if Equals(actionName, n"DropCarriedObject") {
        this.dropBodyHeld = true;
        shouldSendEvent = true;
      } else {
        if Equals(actionName, n"ToggleCrouch") {
          this.crouchHeld = true;
          shouldSendEvent = true;
        } else {
          if Equals(actionName, n"QuickMelee") {
            this.quickMeleeHeld = true;
            shouldSendEvent = true;
          }
        }
      }
    } else {
      if Equals(actionType, gameinputActionType.BUTTON_RELEASED) {
        if Equals(actionName, n"DropCarriedObject") || Equals(actionName, n"click") {
          this.dropBodyHeld = false;
          shouldSendEvent = true;
        } else {
          if Equals(actionName, n"ToggleCrouch") {
            this.crouchHeld = false;
            shouldSendEvent = true;
          } else {
            if Equals(actionName, n"QuickMelee") {
              this.quickMeleeHeld = false;
              shouldSendEvent = true;
            }
          }
        }
      }
    }

    if shouldSendEvent {
      let evt: ref<HotKeyHoldButtonHeldEvent> = new HotKeyHoldButtonHeldEvent();
      evt.isNormalDpadLeftProhibited = this.IsNormalDpadLeftProhibited();
      evt.isNormalDpadRightProhibited = this.IsNormalDpadRightProhibited();
      evt.isNormalDpadUpProhibited = this.IsNormalDpadUpProhibited();
      evt.isNormalDpadDownProhibited = this.IsNormalDpadDownProhibited();
      this.player.QueueEvent(evt);
    }
  }

  public func SetModifiers(modifiersForDpadLeft: array<CName>, modifiersForDpadRight: array<CName>, modifiersForDpadUp: array<CName>, modifiersForDpadDown: array<CName>) -> Void {
    this.modifiersForDpadLeft = modifiersForDpadLeft;
    this.modifiersForDpadRight = modifiersForDpadRight;
    this.modifiersForDpadUp = modifiersForDpadUp;
    this.modifiersForDpadDown = modifiersForDpadDown;
  }

  public func SetPlayer(player: ref<PlayerPuppet>) {
    this.player = player;
  }

  public func IsNormalDpadLeftProhibited() -> Bool {
    return this.IsNormalDpadDirProhibited(this.modifiersForDpadLeft);
  }

  public func IsNormalDpadRightProhibited() -> Bool {
    return this.IsNormalDpadDirProhibited(this.modifiersForDpadRight);
  }

  public func IsNormalDpadUpProhibited() -> Bool {
    return this.IsNormalDpadDirProhibited(this.modifiersForDpadUp);
  }

  public func IsNormalDpadDownProhibited() -> Bool {
    return this.IsNormalDpadDirProhibited(this.modifiersForDpadDown);
  }
  
  private func IsNormalDpadDirProhibited(dpadDirModifiers: array<CName>) -> Bool {
    if this.player.PlayerLastUsedKBM() {
      return false;
    }

    let i: Int32 = 0;
    while i < ArraySize(dpadDirModifiers) {
      if Equals(dpadDirModifiers[i], n"DropCarriedObject") && this.dropBodyHeld {
        return true;
      }
      if Equals(dpadDirModifiers[i], n"ToggleCrouch") && this.crouchHeld {
        return true;
      }
      if Equals(dpadDirModifiers[i], n"QuickMelee") && this.quickMeleeHeld {
        return true;
      }
      i += 1;
    }
    return false;
  }
}

@addField(PlayerPuppet)
private let m_customHotkeyPlayerButtonData: ref<CustomHotkeyPlayerButtonData>;

@addMethod(PlayerPuppet)
public func GetCustomHotkeyPlayerButtonData() -> ref<CustomHotkeyPlayerButtonData> {
  return this.m_customHotkeyPlayerButtonData;
}

@wrapMethod(PlayerPuppet)
protected cb func OnAction(action: ListenerAction, consumer: ListenerActionConsumer) -> Bool {
  this.m_customHotkeyPlayerButtonData.ObserveAction(action);

  wrappedMethod(action, consumer);
}

public class CustomHotkeysConsumablesInventory extends InventoryScriptCallback {
  private let foods: array<array<ItemID>>;
  private let drinks: array<array<ItemID>>;
  private let alcohols: array<array<ItemID>>;
  private let maxDocs: array<array<ItemID>>;
  private let bounceBacks: array<array<ItemID>>;
  private let boosters: array<ItemID>;
  private let drugs: array<ItemID>;
  private let grenades: array<array<array<ItemID>>>;
  private let player: wref<PlayerPuppet>;
  private let itemQualityMap: ref<inkIntHashMap>;
  private let drugIDs: ref<inkIntHashMap>;
  private let foodIDs: ref<inkIntHashMap>;
  private let drinkIDs: ref<inkIntHashMap>;
  private let alcoholIDs: ref<inkIntHashMap>;
  private let maxDocIDs: ref<inkIntHashMap>;
  private let bounceBackIDs: ref<inkIntHashMap>;
  private let grenadeIDs: ref<inkIntHashMap>;
  private let boosterIDs: ref<inkIntHashMap>;
  private let setupComplete: Bool;

  public func Setup(player: ref<PlayerPuppet>, items: array<ItemID>) -> Void {
    this.player = player;
    this.SetupItemQualityMapAndArrays();
    
    for item in items {
      this.addItem(item);
    }
    this.setupComplete = true;
  }

  public func GetItemQuality(item: ItemID) -> Int32 {
    return this.itemQualityMap.Get(TDBID.ToNumber(ItemID.GetTDBID(item)));
  }

  public func CycleGrenade(type: CustomQuickslotItemType, currentItem: ItemID, forward: Bool) -> ItemID {
    let emptyItem: ItemID;
    if !this.setupComplete {
      return emptyItem;
    }

    let index: Int32 = this.GetGrenadeArrayIndexByItemType(type);
    if index == -1 {
      return emptyItem;
    }
    
    let currentQuality = this.GetItemQuality(currentItem);
    if currentQuality == -1 {
      currentQuality = 0;
    }

    let qualityChange: Int32 = forward ? 1 : -1;

    let nextQuality: Int32 = (currentQuality + 1) % ArraySize(this.grenades[index]);
    let firstCheckedQuality: Int32 = nextQuality;
    while true {
      if ArraySize(this.grenades[index][nextQuality]) > 0 {
        return this.grenades[index][nextQuality][0];
      }
      nextQuality = (nextQuality + qualityChange) % ArraySize(this.grenades[index]);
      if nextQuality == firstCheckedQuality {
        break;
      }
    }

    let emptyItem: ItemID;
    return emptyItem;
  }

  public func GetGrenadeWithExactQuality(type: CustomQuickslotItemType, quality: Int32) -> ItemID {
    let emptyItem: ItemID;
    let index: Int32 = this.GetGrenadeArrayIndexByItemType(type);
    if index == -1 {
      return emptyItem;
    }

    if ArraySize(this.grenades[index]) <= quality {
      return emptyItem;
    }

    if ArraySize(this.grenades[index][quality]) > 0 {
      return this.grenades[index][quality][0];
    }

    return emptyItem;
  }

  public func GetGrenadeWithPreferredQuality(type: CustomQuickslotItemType, grenadeQuality: GrenadeQuality) -> ItemID {
    let emptyItem: ItemID;
    if !this.setupComplete {
      return emptyItem;
    }

    let index: Int32 = this.GetGrenadeArrayIndexByItemType(type);
    if index == -1 {
      return emptyItem;
    }
    let quality: Int32 = EnumInt(grenadeQuality);
    if quality == -1 {
      quality = 0;
    }

    if ArraySize(this.grenades[index]) <= quality {
      quality = ArraySize(this.grenades[index]) - 1;
    }

    if quality == -1 {
      return emptyItem;
    }

    let startQuality: Int32 = quality;
    while true {
      if ArraySize(this.grenades[index][quality]) > 0 {
        return this.grenades[index][quality][0];
      }
      quality = (quality + 1) % ArraySize(this.grenades[index]);
      if quality == startQuality {
        break;
      }
    }
    return emptyItem;
  }

  private func GetGrenadeArrayIndexByResourceName(path: CName) -> Int32 {
    if Equals(path, n"Preset_Grenade_Biohazard_Default") {
      return 0;
    }
    if Equals(path, n"Preset_Grenade_Cutting_Default") {
      return 1;
    }
    if Equals(path, n"Preset_Grenade_EMP_Default") {
      return 2;
    }
    if Equals(path, n"Preset_Grenade_Flash_Default") {
      return 3;
    }
    if Equals(path, n"Preset_Grenade_Frag_Default") {
      return 4;
    }
    if Equals(path, n"Preset_Grenade_Incendiary_Default") {
      return 5;
    }
    if Equals(path, n"Preset_Grenade_Frag_Ozob") {
      return 6;
    }
    if Equals(path, n"Preset_Grenade_Recon_Default") {
      return 7;
    }
    return -1;
  }

  private func GetGrenadeArrayIndexByItemType(type: CustomQuickslotItemType) -> Int32 {
    switch type {
      case CustomQuickslotItemType.BiohazardGrenade:
        return 0;
      case CustomQuickslotItemType.CuttingGrenade:
        return 1;
      case CustomQuickslotItemType.EMPGrenade:
        return 2;
      case CustomQuickslotItemType.FlashGrenade:
        return 3;
      case CustomQuickslotItemType.FragGrenade:
        return 4;
      case CustomQuickslotItemType.IncendiaryGrenade:
        return 5;
      case CustomQuickslotItemType.OzobsNose:
        return 6;
      case CustomQuickslotItemType.ReconGrenade:
        return 7;
      default:
        return -1;
    }
  }

  private func GetBestQualityItem(itemArrays: array<array<ItemID>>) -> ItemID {
    let i: Int32 = ArraySize(itemArrays) - 1;
    while i >= 0 {
      if ArraySize(itemArrays[i]) > 0 {
        return itemArrays[i][0];
      }
      i -= 1;
    }
    let emptyItem: ItemID;
    return emptyItem;
  }

  public func GetNewItem(type: CustomQuickslotItemType) -> ItemID {
    switch type {
      case CustomQuickslotItemType.Food:
        return this.GetBestQualityItem(this.foods);
      case CustomQuickslotItemType.Drink:
        return this.GetBestQualityItem(this.drinks);
      case CustomQuickslotItemType.Alcohol:
        return this.GetBestQualityItem(this.alcohols);
      case CustomQuickslotItemType.MaxDoc:
        return this.GetBestQualityItem(this.maxDocs);
      case CustomQuickslotItemType.BounceBack:
        return this.GetBestQualityItem(this.bounceBacks);
      case CustomQuickslotItemType.HealthBooster:
        return this.GetBoosterWithID(t"Items.HealthBooster");
      case CustomQuickslotItemType.MemoryBooster:
        return this.GetBoosterWithID(t"Items.MemoryBooster");
      case CustomQuickslotItemType.StaminaBooster:
        return this.GetBoosterWithID(t"Items.StaminaBooster");
      case CustomQuickslotItemType.CarryCapacityBooster:
        return this.GetBoosterWithID(t"Items.CarryCapacityBooster");
      case CustomQuickslotItemType.OxyBooster:
        return this.GetBoosterWithID(t"Items.OxyBooster");
      case CustomQuickslotItemType.RainbowPoppers:
        return this.GetDrugWithID(t"Drugs.Rainbow Poppers");
      case CustomQuickslotItemType.Glitter:
        return this.GetDrugWithID(t"Drugs.Glitter");
      case CustomQuickslotItemType.FR3SH:
        return this.GetDrugWithID(t"Drugs.FR3SH");
      case CustomQuickslotItemType.SecondWind:
        return this.GetDrugWithID(t"Drugs.Second Wind");
      case CustomQuickslotItemType.Locus:
        return this.GetDrugWithID(t"Drugs.Locus");
      case CustomQuickslotItemType.EVade:
        return this.GetDrugWithID(t"Drugs.E-vade");
      case CustomQuickslotItemType.BeRiteBack:
        return this.GetDrugWithID(t"Drugs.Be-Rite Back");
      case CustomQuickslotItemType.Juice:
        return this.GetDrugWithID(t"Drugs.Juice");
      case CustomQuickslotItemType.Rara:
        return this.GetDrugWithID(t"Drugs.Rara");
      case CustomQuickslotItemType.Ullr:
        return this.GetDrugWithID(t"Drugs.Ullr");
      case CustomQuickslotItemType.ArasakaReflexBooster:
        return this.GetDrugWithID(t"Drugs.Arasaka Reflex Booster");
      case CustomQuickslotItemType.PurpleHaze:
        return this.GetDrugWithID(t"Drugs.Purple Haze");
      case CustomQuickslotItemType.BlackLace:
        return this.GetDrugWithID(t"Items.BlackLaceV0");
      case CustomQuickslotItemType.Donner:
        return this.GetDrugWithID(t"Drugs.Donner");
      case CustomQuickslotItemType.IC3C0LD:
        return this.GetDrugWithID(t"Drugs.IC3C0LD");
      case CustomQuickslotItemType.SyntheticBlood:
        return this.GetDrugWithID(t"Drugs.Synthetic Blood");
      case CustomQuickslotItemType.RoaringPhoenix:
        return this.GetDrugWithID(t"Drugs.Roaring Phoenix");
      case CustomQuickslotItemType.Cleanser:
        return this.GetDrugWithID(t"Drugs.Cleanser");
      case CustomQuickslotItemType.GrisGris:
        return this.GetDrugWithID(t"Drugs.GrisGris");
      case CustomQuickslotItemType.Superjet:
        return this.GetDrugWithID(t"Drugs.Superjet");
      case CustomQuickslotItemType.Brisky:
        return this.GetDrugWithID(t"Drugs.Brisky");
      case CustomQuickslotItemType.Deimos:
        return this.GetDrugWithID(t"Drugs.Deimos");
      case CustomQuickslotItemType.Aspis:
        return this.GetDrugWithID(t"Drugs.Aspis");
      case CustomQuickslotItemType.Karanos:
        return this.GetDrugWithID(t"Drugs.Karanos");
      default:
        let itemToReturn: ItemID;
        return itemToReturn;
    }
  }

  public func ConsumableIdBelongsToType(id: TweakDBID, type: CustomQuickslotItemType) -> Bool {
    switch type {
      case CustomQuickslotItemType.Food:
        if this.foodIDs.KeyExist(TDBID.ToNumber(id)) {
          return true;
        }
        break;
      case CustomQuickslotItemType.Drink:
        if this.drinkIDs.KeyExist(TDBID.ToNumber(id)) {
          return true;
        }
        break;
      case CustomQuickslotItemType.Alcohol:
        if this.alcoholIDs.KeyExist(TDBID.ToNumber(id)) {
          return true;
        }
        break;
      case CustomQuickslotItemType.HealthBooster:
      case CustomQuickslotItemType.StaminaBooster:
      case CustomQuickslotItemType.MemoryBooster:
      case CustomQuickslotItemType.CarryCapacityBooster:
      case CustomQuickslotItemType.OxyBooster:
        if this.boosterIDs.KeyExist(TDBID.ToNumber(id)) {
          return true;
        }
        break;
      case CustomQuickslotItemType.MaxDoc:
        if this.maxDocIDs.KeyExist(TDBID.ToNumber(id)) {
          return true;
        }
        break;
      case CustomQuickslotItemType.BounceBack:
        if this.bounceBackIDs.KeyExist(TDBID.ToNumber(id)) {
          return true;
        }
        break;
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
        if this.drugIDs.KeyExist(TDBID.ToNumber(id)) {
          return true;
        }
        break;
      default:
        break;
    }
    return false;
  }

  private func GetBoosterWithID(id: TweakDBID) -> ItemID {
    for item in this.boosters {
      let tweakId: TweakDBID = ItemID.GetTDBID(item);
      if tweakId == id {
        return item;
      }
    }
    let emptyItem: ItemID;
    return emptyItem;
  }

  private func GetDrugWithID(id: TweakDBID) -> ItemID {
    for item in this.drugs {
      let tweakId: TweakDBID = ItemID.GetTDBID(item);
      if tweakId == id {
        return item;
      }
    }
    let emptyItem: ItemID;
    return emptyItem;
  }

  public func OnItemQuantityChanged(itemID: ItemID, diff: Int32, total: Uint32, flaggedAsSilent: Bool) -> Void {
    let totalInt: Int32 = Cast(total);
    if diff > 0 && diff == totalInt {
      this.addItem(itemID);
    } else {
      if diff < 0 && totalInt == 0 {
        this.removeItem(itemID);
      }
    }

    let evt: ref<CustomHotkeyItemQuantityChangedEvent> = new CustomHotkeyItemQuantityChangedEvent();
    evt.itemID = itemID;
    evt.diff = diff;
    evt.total = total;
    this.player.QueueEvent(evt);
  }

  private func addItem(itemID: ItemID) -> Void {
    let tweakId: TweakDBID = ItemID.GetTDBID(itemID);
    let quality: Int32 = this.itemQualityMap.Get(TDBID.ToNumber(tweakId));
    if quality == -1 {
      // if it's an item we haven't categorized, it goes in the lowest category
      quality = 0;
    }

    let consumable: ref<ConsumableItem_Record> = TweakDBInterface.GetConsumableItemRecord(tweakId);
    if IsDefined(consumable) {
      if this.foodIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayPush(this.foods[quality < ArraySize(this.foods) ? quality : 0], itemID);
        return;
      }
      if this.drinkIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayPush(this.drinks[quality < ArraySize(this.drinks) ? quality : 0], itemID);
        return;
      }
      if this.alcoholIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayPush(this.alcohols[quality < ArraySize(this.alcohols) ? quality : 0], itemID);
        return;
      }
      if this.drugIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayPush(this.drugs, itemID);
        return;
      }
      if this.maxDocIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayPush(this.maxDocs[quality < ArraySize(this.maxDocs) ? quality : 0], itemID);
        return;
      }
      if this.bounceBackIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayPush(this.bounceBacks[quality < ArraySize(this.bounceBacks) ? quality : 0], itemID);
        return;
      }
      if this.boosterIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayPush(this.boosters, itemID);
        return;
      }
      return;
    }
    
    let grenade: ref<Grenade_Record> = TweakDBInterface.GetGrenadeRecord(tweakId);
    if IsDefined(grenade) {
      let index: Int32 = this.GetGrenadeArrayIndexByResourceName(grenade.AppearanceResourceName());
      if index != -1 {
        ArrayPush(this.grenades[index][quality < ArraySize(this.grenades[index]) ? quality : 0], itemID);
      }
    }
  }

  private func removeItem(itemID: ItemID) -> Void {
    let tweakId: TweakDBID = ItemID.GetTDBID(itemID);
    let quality: Int32 = this.itemQualityMap.Get(TDBID.ToNumber(tweakId));
    if quality == -1 {
      // if it's an item we haven't categorized, it goes in the lowest category
      quality = 0;
    }
    
    let consumable: ref<ConsumableItem_Record> = TweakDBInterface.GetConsumableItemRecord(tweakId);
    if IsDefined(consumable) {
      if this.foodIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayRemove(this.foods[quality < ArraySize(this.foods) ? quality : 0], itemID);
        return;
      }
      if this.drinkIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayRemove(this.drinks[quality < ArraySize(this.drinks) ? quality : 0], itemID);
        return;
      }
      if this.alcoholIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayRemove(this.alcohols[quality < ArraySize(this.alcohols) ? quality : 0], itemID);
        return;
      }
      if this.drugIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayRemove(this.drugs, itemID);
        return;
      }
      if this.maxDocIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayRemove(this.maxDocs[quality < ArraySize(this.maxDocs) ? quality : 0], itemID);
        return;
      }
      if this.bounceBackIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayRemove(this.bounceBacks[quality < ArraySize(this.bounceBacks) ? quality : 0], itemID);
        return;
      }
      if this.boosterIDs.KeyExist(TDBID.ToNumber(tweakId)) {
        ArrayRemove(this.boosters, itemID);
        return;
      }
      return;
    }

    let grenade: ref<Grenade_Record> = TweakDBInterface.GetGrenadeRecord(tweakId);
    if IsDefined(grenade) {
      let index: Int32 = this.GetGrenadeArrayIndexByResourceName(grenade.AppearanceResourceName());
      if index != -1 {
        ArrayRemove(this.grenades[index][quality < ArraySize(this.grenades[index]) ? quality : 0], itemID);
      }
    }
  }

  public func SetupItemQualityMapAndArrays() -> Void {
    let map: ref<inkIntHashMap> = new inkIntHashMap();
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood1"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood2"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood3"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood4"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood5"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood6"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood7"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood8"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood9"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood10"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood11"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood12"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood13"), 3);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood1"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood2"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood3"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood4"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood5"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood6"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood7"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood8"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood9"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood10"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood11"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood12"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood13"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood14"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood15"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood16"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood17"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood18"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood19"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood20"), 2);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood1"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood2"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood3"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood4"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood5"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood6"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood7"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood8"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood9"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood10"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood11"), 0); // Cat Food
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood12"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood13"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood14"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood15"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood16"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood17"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood18"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood19"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood20"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood21"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood22"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood23"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood24"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood25"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood26"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood27"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood28"), 1);
    map.Insert(TDBID.ToNumber(t"Items.NomadsFood1"), 3); // In FGR Nomad quality is same as Good
    map.Insert(TDBID.ToNumber(t"Items.NomadsFood2"), 3);
    for i in [0, 1, 2, 3] {
      let food: array<ItemID>;
      ArrayPush(this.foods, food);
    }
    
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink1"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink2"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink3"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink4"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink5"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink6"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink7"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink8"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink9"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink10"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink11"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink1"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink2"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink3"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink4"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink5"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink6"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink7"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink8"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink9"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink10"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink11"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink12"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink13"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink14"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink1"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink2"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink3"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink4"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink5"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink6"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink7"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink8"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink9"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink10"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink11"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink12"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink13"), 0);
    map.Insert(TDBID.ToNumber(t"Items.NomadsDrink1"), 2);
    map.Insert(TDBID.ToNumber(t"Items.NomadsDrink2"), 2);
    for i in [0, 1, 2] {
      let drinks: array<ItemID>;
      ArrayPush(this.drinks, drinks);
    }

    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol1"), 3);
    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol2"), 3);
    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol3"), 3);
    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol4"), 3);
    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol5"), 3);
    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol6"), 3);
    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol7"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityAlcohol1"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityAlcohol2"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityAlcohol3"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityAlcohol4"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityAlcohol5"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityAlcohol6"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol1"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol2"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol3"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol4"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol5"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol6"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol7"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol1"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol2"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol3"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol4"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol5"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol6"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol7"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol8"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol9"), 0);
    map.Insert(TDBID.ToNumber(t"Items.NomadsAlcohol1"), 2);
    map.Insert(TDBID.ToNumber(t"Items.NomadsAlcohol2"), 2);
    for i in [0, 1, 2, 3] {
      let alcohol: array<ItemID>;
      ArrayPush(this.alcohols, alcohol);
    }

    map.Insert(TDBID.ToNumber(t"Items.FirstAidWhiffV0"), 0);
    map.Insert(TDBID.ToNumber(t"Items.FirstAidWhiffV1"), 1);
    map.Insert(TDBID.ToNumber(t"Items.FirstAidWhiffV2"), 2);
    for i in [0, 1, 2] {
      let maxDoc: array<ItemID>;
      ArrayPush(this.maxDocs, maxDoc);
    }

    map.Insert(TDBID.ToNumber(t"Items.BonesMcCoy70V0"), 0);
    map.Insert(TDBID.ToNumber(t"Items.BonesMcCoy70V1"), 1);
    map.Insert(TDBID.ToNumber(t"Items.BonesMcCoy70V2"), 2);
    for i in [0, 1, 2] {
      let bounceBack: array<ItemID>;
      ArrayPush(this.bounceBacks, bounceBack);
    }

    // populate grenades array^3
    for i in [0, 1, 2, 3, 4, 5, 6, 7] {
      let grenadesArray: array<array<ItemID>>;
      ArrayPush(this.grenades, grenadesArray);
    }

    map.Insert(TDBID.ToNumber(t"Items.GrenadeBiohazardRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeBiohazardSticky"), 1);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeBiohazardHoming"), 2);
    for i in [0, 1, 2] {
      let grenade: array<ItemID>;
      ArrayPush(this.grenades[0], grenade);
    }
    
    map.Insert(TDBID.ToNumber(t"Items.GrenadeCuttingRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeCuttingSticky"), 1);
    for i in [0, 1, 2] {
      let grenade: array<ItemID>;
      ArrayPush(this.grenades[1], grenade);
    }

    map.Insert(TDBID.ToNumber(t"Items.GrenadeEMPRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeEMPSticky"), 1);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeEMPHoming"), 2);
    for i in [0, 1, 2] {
      let grenade: array<ItemID>;
      ArrayPush(this.grenades[2], grenade);
    }

    map.Insert(TDBID.ToNumber(t"Items.GrenadeFlashRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeFlashSticky"), 1);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeFlashHoming"), 2);
    for i in [0, 1, 2] {
      let grenade: array<ItemID>;
      ArrayPush(this.grenades[3], grenade);
    }

    map.Insert(TDBID.ToNumber(t"Items.GrenadeFragRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeFragSticky"), 1);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeFragHoming"), 2);
    for i in [0, 1, 2] {
      let grenade: array<ItemID>;
      ArrayPush(this.grenades[4], grenade);
    }

    map.Insert(TDBID.ToNumber(t"Items.GrenadeIncendiaryRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeIncendiarySticky"), 1);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeIncendiaryHoming"), 2);
    for i in [0, 1, 2] {
      let grenade: array<ItemID>;
      ArrayPush(this.grenades[5], grenade);
    }

    map.Insert(TDBID.ToNumber(t"Items.GrenadeOzobsNose"), 0);
    for i in [0, 1, 2] {
      let grenade: array<ItemID>;
      ArrayPush(this.grenades[6], grenade);
    }

    map.Insert(TDBID.ToNumber(t"Items.GrenadeReconRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeReconSticky"), 1);
    for i in [0, 1, 2] {
      let grenade: array<ItemID>;
      ArrayPush(this.grenades[7], grenade);
    }

    // WE3D compat
    map.Insert(TDBID.ToNumber(t"Drugs.Rainbow Poppers"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Glitter"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.FR3SH"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Second Wind"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Locus"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.E-vade"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Be-Rite Back"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Juice"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Rara"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Ullr"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Arasaka Reflex Booster"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Purple Haze"), 1);
    map.Insert(TDBID.ToNumber(t"Items.BlackLaceV0"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Donner"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.IC3C0LD"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Synthetic Blood"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Roaring Phoenix"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Cleanser"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.GrisGris"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Superjet"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Brisky"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Deimos"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Aspis"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Karanos"), 1);

    this.itemQualityMap = map;

    map = new inkIntHashMap();
    map.Insert(TDBID.ToNumber(t"Drugs.Rainbow Poppers"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Glitter"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.FR3SH"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Second Wind"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Locus"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.E-vade"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Be-Rite Back"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Juice"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Rara"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Ullr"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Arasaka Reflex Booster"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Purple Haze"), 1);
    map.Insert(TDBID.ToNumber(t"Items.BlackLaceV0"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Donner"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.IC3C0LD"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Synthetic Blood"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Roaring Phoenix"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Cleanser"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.GrisGris"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Superjet"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Brisky"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Deimos"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Aspis"), 1);
    map.Insert(TDBID.ToNumber(t"Drugs.Karanos"), 1);
    this.drugIDs = map;

    map = new inkIntHashMap();
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood1"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood2"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood3"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood4"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood5"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood6"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood7"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood8"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood9"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood10"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood11"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood12"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityFood13"), 3);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood1"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood2"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood3"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood4"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood5"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood6"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood7"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood8"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood9"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood10"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood11"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood12"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood13"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood14"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood15"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood16"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood17"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood18"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood19"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityFood20"), 2);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood1"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood2"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood3"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood4"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood5"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood6"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood7"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood8"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood9"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood10"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood11"), 0); // Cat Food
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood12"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood13"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood14"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood15"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood16"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood17"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood18"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood19"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood20"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood21"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood22"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood23"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood24"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood25"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood26"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood27"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityFood28"), 1);
    map.Insert(TDBID.ToNumber(t"Items.NomadsFood1"), 3); // In FGR Nomad quality is same as Good
    map.Insert(TDBID.ToNumber(t"Items.NomadsFood2"), 3);
    this.foodIDs = map;

    map = new inkIntHashMap();
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink1"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink2"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink3"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink4"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink5"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink6"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink7"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink8"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink9"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink10"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityDrink11"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink1"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink2"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink3"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink4"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink5"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink6"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink7"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink8"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink9"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink10"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink11"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink12"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink13"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityDrink14"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink1"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink2"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink3"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink4"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink5"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink6"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink7"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink8"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink9"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink10"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink11"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink12"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityDrink13"), 0);
    map.Insert(TDBID.ToNumber(t"Items.NomadsDrink1"), 2);
    map.Insert(TDBID.ToNumber(t"Items.NomadsDrink2"), 2);
    this.drinkIDs = map;

    map = new inkIntHashMap();
    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol1"), 3);
    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol2"), 3);
    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol3"), 3);
    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol4"), 3);
    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol5"), 3);
    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol6"), 3);
    map.Insert(TDBID.ToNumber(t"Items.TopQualityAlcohol7"), 3);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityAlcohol1"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityAlcohol2"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityAlcohol3"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityAlcohol4"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityAlcohol5"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GoodQualityAlcohol6"), 2);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol1"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol2"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol3"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol4"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol5"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol6"), 1);
    map.Insert(TDBID.ToNumber(t"Items.MediumQualityAlcohol7"), 1);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol1"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol2"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol3"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol4"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol5"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol6"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol7"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol8"), 0);
    map.Insert(TDBID.ToNumber(t"Items.LowQualityAlcohol9"), 0);
    map.Insert(TDBID.ToNumber(t"Items.NomadsAlcohol1"), 2);
    map.Insert(TDBID.ToNumber(t"Items.NomadsAlcohol2"), 2);
    this.alcoholIDs = map;
    
    map = new inkIntHashMap();
    map.Insert(TDBID.ToNumber(t"Items.FirstAidWhiffV0"), 0);
    map.Insert(TDBID.ToNumber(t"Items.FirstAidWhiffV1"), 1);
    map.Insert(TDBID.ToNumber(t"Items.FirstAidWhiffV2"), 2);
    this.maxDocIDs = map;

    map = new inkIntHashMap();
    map.Insert(TDBID.ToNumber(t"Items.BonesMcCoy70V0"), 0);
    map.Insert(TDBID.ToNumber(t"Items.BonesMcCoy70V1"), 1);
    map.Insert(TDBID.ToNumber(t"Items.BonesMcCoy70V2"), 2);
    this.bounceBackIDs = map;

    map = new inkIntHashMap();
    map.Insert(TDBID.ToNumber(t"Items.GrenadeBiohazardRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeBiohazardHoming"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeCuttingRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeEMPRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeEMPSticky"), 1);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeEMPHoming"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeFlashRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeFlashHoming"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeFragRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeFragSticky"), 1);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeFragHoming"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeIncendiaryRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeIncendiarySticky"), 1);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeIncendiaryHoming"), 2);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeOzobsNose"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeReconRegular"), 0);
    map.Insert(TDBID.ToNumber(t"Items.GrenadeReconSticky"), 1);
    this.grenadeIDs = map;

    map = new inkIntHashMap();
    map.Insert(TDBID.ToNumber(t"Items.HealthBooster"), 0);
    map.Insert(TDBID.ToNumber(t"Items.CarryCapacityBooster"), 0);
    map.Insert(TDBID.ToNumber(t"Items.MemoryBooster"), 0);
    map.Insert(TDBID.ToNumber(t"Items.OxyBooster"), 0);
    map.Insert(TDBID.ToNumber(t"Items.StaminaBooster"), 0);
    this.boosterIDs = map;

  }
}

public class CustomHotkeyItemQuantityChangedEvent extends Event {
  public let itemID: ItemID;
  public let diff: Int32;
  public let total: Uint32;
}

@wrapMethod(SubtitlesGameController)
protected func CreateLine(lineSpawnData: ref<LineSpawnData>) -> Void {
  wrappedMethod(lineSpawnData);

  let player: wref<PlayerPuppet> = this.GetPlayerControlledObject() as PlayerPuppet;
  if IsDefined(player) {
    player.SubtitlesPresent(true);
  }
}

@wrapMethod(SubtitlesGameController)
protected func OnHideLine(lineData: subtitleLineMapEntry) -> Void {
  wrappedMethod(lineData);

  let player: wref<PlayerPuppet> = this.GetPlayerControlledObject() as PlayerPuppet;
  if IsDefined(player) && this.m_subtitlesPanel.GetNumChildren() == 0 {
    player.SubtitlesPresent(false);
  }
}

@wrapMethod(SubtitlesGameController)
protected func OnHideLineByData(lineData: subtitleLineMapEntry) -> Void {
  wrappedMethod(lineData);

  if this.m_subtitlesPanel.GetNumChildren() == 0 {
    let player: wref<PlayerPuppet> = this.GetPlayerControlledObject() as PlayerPuppet;
    if IsDefined(player) {
      player.SubtitlesPresent(false);
    }
  }
}

@addMethod(PlayerPuppet)
public func SubtitlesPresent(present: Bool) -> Void {
  let evt: ref<CustomQuickslotsInDialog> = new CustomQuickslotsInDialog();
  evt.subtitlesVisible = present;
  this.QueueEvent(evt);
}

public class CustomQuickslotsInDialog extends Event {
  public let subtitlesVisible: Bool;
}


// in CET json config, have type/subtype associated with JSON objects
// turn into a map in redscript, from TweakDBID to list of applicable item slots

// when item is added inventory, check its TweakDBID.

public class CustomQuickSlotItem {
  public let type: String;
  public let subType: String;
  public let id: TweakDBID;
  public let sortPrecidence: Int32;
}

public class CustomQuickslotItemSort extends IScriptable {
  public final static func InsertionSort(items: script_ref<array<ref<CustomQuickSlotItem>>>) -> Void {
    CustomQuickslotItemSort.InsertionSort(items, 0, ArraySize(Deref(items)));
  }

  private final static func InsertionSort(items: script_ref<array<ref<CustomQuickSlotItem>>>, leftIndex: Int32, rightIndex: Int32) -> Void {
    let i: Int32 = leftIndex + 1;
    while i < ArraySize(Deref(items)) && i < rightIndex + 1 {
      let j: Int32 = i;
      while j > 0 && j > leftIndex && CustomQuickslotItemSort.Less(Deref(items)[j], Deref(items)[j - 1]) {
        CustomQuickslotItemSort.Exchange(items, j, j - 1);
        j -= 1;
      }
      i += 1;
    }
  }

  private final static func Shuffle(items: script_ref<array<ref<CustomQuickSlotItem>>>) -> Void {
    let i: Int32 = ArraySize(Deref(items)) - 1;
    while i > 0 {
      let j: Int32 = RandRange(0, i);
      CustomQuickslotItemSort.Exchange(items, i, j);
      i -= 1;
    }
  }
  
  public final static func QuickSort(items: script_ref<array<ref<CustomQuickSlotItem>>>) -> Void {
    CustomQuickslotItemSort.Shuffle(items);
    CustomQuickslotItemSort.QuickSort(items, 0, ArraySize(Deref(items)) - 1);
  }

  private final static func QuickSort(items: script_ref<array<ref<CustomQuickSlotItem>>>, leftIndex: Int32, rightIndex: Int32) -> Void {
    let INSERTION_SORT_CUTOFF: Int32 = 5;

    if rightIndex <= leftIndex + INSERTION_SORT_CUTOFF {
      CustomQuickslotItemSort.InsertionSort(items, leftIndex, rightIndex);  
      return;
    }

    let j: Int32 = CustomQuickslotItemSort.Partition(items, leftIndex, rightIndex);
    CustomQuickslotItemSort.QuickSort(items, leftIndex, j - 1);
    CustomQuickslotItemSort.QuickSort(items, j + 1, rightIndex);
  }

  public final static func Quick3WaySort(items: script_ref<array<ref<CustomQuickSlotItem>>>) -> Void {
    CustomQuickslotItemSort.Shuffle(items);
    CustomQuickslotItemSort.Quick3WaySort(items, 0, ArraySize(Deref(items)) - 1);
  }

  private final static func Quick3WaySort(items: script_ref<array<ref<CustomQuickSlotItem>>>, leftIndex: Int32, rightIndex: Int32) -> Void {
    let INSERTION_SORT_CUTOFF: Int32 = 5;

    if rightIndex <= leftIndex + INSERTION_SORT_CUTOFF {
      CustomQuickslotItemSort.InsertionSort(items, leftIndex, rightIndex);  
      return;
    }

    let lt: Int32 = leftIndex;
    let i: Int32 = leftIndex + 1;
    let gt: Int32 = rightIndex;

    let item: ref<CustomQuickSlotItem> = Deref(items)[leftIndex];

    while i <= gt {
      let cmp: Int32 = CustomQuickslotItemSort.Compare(Deref(items)[i], item);
      if cmp < 0 {
        CustomQuickslotItemSort.Exchange(items, lt, i);
        lt += 1;
        i += 1;
      } else {
        if cmp > 0 {
          CustomQuickslotItemSort.Exchange(items, i, gt);
          gt -= 1;
        } else {
          i += 1;
        }
      }
    }

    CustomQuickslotItemSort.QuickSort(items, leftIndex, lt - 1);
    CustomQuickslotItemSort.QuickSort(items, gt + 1, rightIndex);
  }

  private final static func Partition(items: script_ref<array<ref<CustomQuickSlotItem>>>, leftIndex: Int32, rightIndex: Int32) -> Int32 {
    let i: Int32 = leftIndex;
    let j: Int32 = rightIndex + 1;
    let item: ref<CustomQuickSlotItem> = Deref(items)[leftIndex];
    while true {
      while CustomQuickslotItemSort.Less(Deref(items)[i += 1], item) {
        if i == rightIndex {
          break;
        }
      }
      while CustomQuickslotItemSort.Less(item, Deref(items)[j -= 1]) {
        if j == leftIndex {
          break;
        }
      }
      if i >= j {
        break;
      }
      CustomQuickslotItemSort.Exchange(items, i, j);
    }

    CustomQuickslotItemSort.Exchange(items, leftIndex, j);
    return j;
  }

  private final static func Exchange(items: script_ref<array<ref<CustomQuickSlotItem>>>, a: Int32, b: Int32) -> Void {
    let temp: ref<CustomQuickSlotItem> = Deref(items)[a];
    Deref(items)[a] = Deref(items)[b];
    Deref(items)[b] = temp;
  }

  private final static func Less(left: ref<CustomQuickSlotItem>, right: ref<CustomQuickSlotItem>) -> Bool {
    return left.sortPrecidence < right.sortPrecidence;
  }

  private final static func Compare(left: ref<CustomQuickSlotItem>, right: ref<CustomQuickSlotItem>) -> Int32 {
    if left.sortPrecidence < right.sortPrecidence {
      return -1;
    }
    if left.sortPrecidence > right.sortPrecidence {
      return 1;
    }
    return 0;
  }
}