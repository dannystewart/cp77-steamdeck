import CustomQuickslotsConfig.*

@addField(HotkeysWidgetController)
let m_customHotkeyFood: wref<inkWidget>;

@addField(HotkeysWidgetController)
let m_customHotkeyDrink: wref<inkWidget>;

@addField(HotkeysWidgetController)
let m_customHotkeyHealthBooster: wref<inkWidget>;

@addField(HotkeysWidgetController)
let m_customHotkeyStaminaBooster: wref<inkWidget>;

@addField(HotkeysWidgetController)
let m_customHotkeyRAMJolt: wref<inkWidget>;

@addField(HotkeysWidgetController)
let m_customHotkeyCapacityBooster: wref<inkWidget>;

@addField(HotkeysWidgetController)
let m_numVisibleCustomHotkeys: Int32;

@addField(HotkeysWidgetController)
let m_lastE3OffsetLength: Float;

// Lua module overrides these functions - bodies are just to silence linter
@addMethod(HotkeysWidgetController)
private func GetCustomQuickslots() -> array<ref<CustomQuickslot>> { return []; }

@addMethod(HotkeysWidgetController)
private func DefaultSlotOpacity() -> Float { return 0; }

@addMethod(HotkeysWidgetController)
private func SlotOpacityWhileSubtitlesOnScreen() -> Float { return 0; }

@addMethod(HotkeysWidgetController)
private func SlotFadeInDelay() -> Float { return 0; }

@addMethod(HotkeysWidgetController)
private func SlotFadeInDuration() -> Float { return 0; }

@addMethod(HotkeysWidgetController)
private func IsE3HudCompatibilityMode() -> Bool { return false; }

@addMethod(HotkeysWidgetController)
private func SmallSlotsMode() -> Bool { return false; }

@addMethod(HotkeysWidgetController)
public func CustomQuickslotsRefreshSlots() -> Void {
  inkCompoundRef.RemoveAllChildren(this.m_hotkeysList);

  this.m_consumables = this.SpawnFromLocal(inkWidgetRef.Get(this.m_hotkeysList), n"DPAD_UP");
  this.m_gadgets = this.SpawnFromLocal(inkWidgetRef.Get(this.m_hotkeysList), n"RB");

  this.AddCustomQuickslots();

  if this.IsE3HudCompatibilityMode() {
    this.UpdateLengthAndScale();
  }
}

@addMethod(HotkeysWidgetController)
private func AddCustomQuickslots() -> Void {
  let quickslots: array<ref<CustomQuickslot>> = this.GetCustomQuickslots();
  let modifiersForDpadLeft: array<CName>;
  let modifiersForDpadRight: array<CName>;
  let modifiersForDpadUp: array<CName>;
  let modifiersForDpadDown: array<CName>;

  let list: wref<inkCompoundWidget> = inkWidgetRef.Get(this.m_hotkeysList) as inkCompoundWidget;

  let i: Int32 = 0;
  while i < ArraySize(quickslots) {
    let quickslot: ref<CustomQuickslot> = quickslots[i];
    let slotName: String = "customHotkey_" + i;
    let customHotkey: wref<inkWidget> = this.SpawnFromLocal(list, n"DPAD_UP");
    customHotkey.SetName(StringToName(slotName));

    if Equals(quickslot.gamepadInput, n"dpad_left") {
      if !ArrayContains(modifiersForDpadLeft, quickslot.gamepadHoldModifier) {
        ArrayPush(modifiersForDpadLeft, quickslot.gamepadHoldModifier);
      }
    }
    if Equals(quickslot.gamepadInput, n"dpad_right") {
      if !ArrayContains(modifiersForDpadRight, quickslot.gamepadHoldModifier) {
        ArrayPush(modifiersForDpadRight, quickslot.gamepadHoldModifier);
      }
    }
    if Equals(quickslot.gamepadInput, n"dpad_up") {
      if !ArrayContains(modifiersForDpadUp, quickslot.gamepadHoldModifier) {
        ArrayPush(modifiersForDpadUp, quickslot.gamepadHoldModifier);
      }
    }
    if Equals(quickslot.gamepadInput, n"dpad_down") {
      if !ArrayContains(modifiersForDpadDown, quickslot.gamepadHoldModifier) {
        ArrayPush(modifiersForDpadDown, quickslot.gamepadHoldModifier);
      }
    }

    i += 1;
  }

  this.m_CustomHotkeyHideAnim = new inkAnimDef();
  let alphaInterpolator: ref<inkAnimTransparency> = new inkAnimTransparency();
  alphaInterpolator.SetStartTransparency(this.SlotOpacityWhileSubtitlesOnScreen());
  alphaInterpolator.SetEndTransparency(this.DefaultSlotOpacity());
  alphaInterpolator.SetDuration(this.SlotFadeInDuration());
  alphaInterpolator.SetType(inkanimInterpolationType.Linear);
  alphaInterpolator.SetMode(inkanimInterpolationMode.EasyIn);
  alphaInterpolator.SetStartDelay(this.SlotFadeInDelay());
  this.m_CustomHotkeyHideAnim.AddInterpolator(alphaInterpolator);

  this.m_player.GetCustomHotkeyPlayerButtonData().SetModifiers(modifiersForDpadLeft, modifiersForDpadRight, modifiersForDpadUp, modifiersForDpadDown);
  list.SetOpacity(this.DefaultSlotOpacity());

  if this.SmallSlotsMode() {
    list.SetChildMargin(new inkMargin(-13., 0, -13., 0));

    let i: Int32 = 0;
    while i < list.GetNumChildren() {
      let HotkeyMainFlex: wref<inkFlex> = list.GetWidget(i) as inkFlex;
      let wrapper_Dpad_Down: wref<inkVerticalPanel> = HotkeyMainFlex.GetWidget(0) as inkVerticalPanel;
      let item_wrapper_Dpad_Down: wref<inkFlex> = wrapper_Dpad_Down.GetWidget(0) as inkFlex;

      item_wrapper_Dpad_Down.SetScale(new Vector2(0.706, 0.706));

      i += 1;
    }
  }
  else {
    list.SetChildMargin(new inkMargin(9, 0, 0, 0));
  }
}

@wrapMethod(HotkeysWidgetController)
protected cb func OnInitialize() -> Bool {
  wrappedMethod();

  let hudEntryInfo = this.m_root.GetUserData(n"inkHudEntryInfo") as inkHudEntryInfo;
  hudEntryInfo.size = new Vector2(3500, 300);

  if this.IsE3HudCompatibilityMode() {
    let quickslots: array<ref<CustomQuickslot>> = this.GetCustomQuickslots();
    this.m_numVisibleCustomHotkeys = ArraySize(quickslots);
    this.AdjustWidget(ArraySize(quickslots));
  }

  this.AddCustomQuickslots();
}

@addField(HotkeysWidgetController)
private let m_CustomHotkeyHideAnim: ref<inkAnimDef>;

@addField(HotkeysWidgetController)
private let m_CustomHotkeyHideAnimProxy: ref<inkAnimProxy>;

@addField(HotkeysWidgetController)
private let m_CustomHotkeyUtilsHideAnimProxy: ref<inkAnimProxy>;

@addMethod(HotkeysWidgetController)
protected cb func OnSubtitleVisibilityEvent(evt: ref<CustomQuickslotsInDialog>) -> Bool {
  if evt.subtitlesVisible {
    if IsDefined(this.m_CustomHotkeyHideAnimProxy) {
      if this.m_CustomHotkeyHideAnimProxy.IsPlaying() {
        this.m_CustomHotkeyHideAnimProxy.Stop();
        this.m_CustomHotkeyHideAnimProxy = null;
      }
    }
    if this.IsE3HudCompatibilityMode() {
      inkWidgetRef.Get(this.m_utilsList).SetOpacity(this.SlotOpacityWhileSubtitlesOnScreen());
    }
    inkWidgetRef.Get(this.m_hotkeysList).SetOpacity(this.SlotOpacityWhileSubtitlesOnScreen());
  }
  else {
    if inkWidgetRef.GetOpacity(this.m_hotkeysList) < this.DefaultSlotOpacity() {
      if !(IsDefined(this.m_CustomHotkeyHideAnimProxy) && this.m_CustomHotkeyHideAnimProxy.IsPlaying()) {
        this.m_CustomHotkeyHideAnimProxy = inkWidgetRef.PlayAnimation(this.m_hotkeysList, this.m_CustomHotkeyHideAnim);
      }
      if this.IsE3HudCompatibilityMode() && !(IsDefined(this.m_CustomHotkeyUtilsHideAnimProxy) && this.m_CustomHotkeyUtilsHideAnimProxy.IsPlaying()) {
        this.m_CustomHotkeyUtilsHideAnimProxy = inkWidgetRef.PlayAnimation(this.m_hotkeysList, this.m_CustomHotkeyHideAnim);
      }
    } 
  }
}

public class HotkeyVisibilityUpdateEvent extends Event {}

@addMethod(HotkeysWidgetController)
protected cb func OnHotkeyVisibilityUpdate(evt: ref<HotkeyVisibilityUpdateEvent>) -> Bool {
  this.UpdateLengthAndScale();
}

@addMethod(HotkeysWidgetController)
private func UpdateLengthAndScale() -> Void {
  let numVisibleQuickslots: Int32 = 0;

  let quickslots: array<ref<CustomQuickslot>> = this.GetCustomQuickslots();
  let i: Int32 = 0;
  while i < ArraySize(quickslots) {
    let slotName: String = "customHotkey_" + i;
    let slot: ref<inkWidget> = inkCompoundRef.GetWidget(this.m_hotkeysList, StringToName(slotName));
    if slot.IsVisible() {
      numVisibleQuickslots += 1;
    }
    i += 1;
  }
  
  let mainCanvas: ref<inkCanvas> = this.m_root.GetWidget(n"mainCanvas") as inkCanvas;
  let tempNumHotkeysFloat: Float = Cast(this.m_numVisibleCustomHotkeys);
  let currentSize: Vector2 = mainCanvas.GetSize();
  let scale: Float = currentSize.X / this.m_lastE3OffsetLength;
  tempNumHotkeysFloat = Cast(numVisibleQuickslots);

  let newLength: Float = (this.GetGeneralOffset() + this.GetPerSlotOffset() * tempNumHotkeysFloat) * scale;

  mainCanvas.SetSize(new Vector2(newLength, currentSize.Y));

  this.m_lastE3OffsetLength = newLength;
  this.m_numVisibleCustomHotkeys = numVisibleQuickslots;
}

@addMethod(HotkeysWidgetController)
private func GetPerSlotOffset() -> Float {
  return this.SmallSlotsMode() ? 92.0 : 128.0;
}

@addMethod(HotkeysWidgetController)
private func GetGeneralOffset() -> Float {
  return this.SmallSlotsMode() ? 550.0 : 575.0;
}

@addMethod(HotkeysWidgetController)
protected cb func AdjustWidget(numSlots: Int32) -> Bool {
  let slotsFloat: Float = Cast(numSlots); 

  let length: Float = this.GetGeneralOffset() + this.GetPerSlotOffset() * slotsFloat;
  this.m_lastE3OffsetLength = length;

  this.m_root.SetSize(new Vector2(this.GetGeneralOffset(), 300.0));
  this.m_root.SetAnchor(inkEAnchor.TopRight);
  this.m_root.SetAnchorPoint(new Vector2(1.0, 0.0));
  this.m_root.SetMargin(new inkMargin(0.0, -25.0, 0.0, 0.0));

  let mainCanvas: ref<inkCanvas> = this.m_root.GetWidget(n"mainCanvas") as inkCanvas;
  mainCanvas.SetSize(new Vector2(length, 300.0));
  mainCanvas.SetAnchor(inkEAnchor.TopLeft);
  mainCanvas.SetAnchorPoint(new Vector2(1.0, 0.0));
  mainCanvas.SetHAlign(inkEHorizontalAlign.Left);
  mainCanvas.SetVAlign(inkEVerticalAlign.Top);
  mainCanvas.SetMargin(new inkMargin(200.0, -25.0, 0.0, 0.0));
  mainCanvas.SetRenderTransformPivot(new Vector2(1.0, 0.0));

  let listLeft: ref<inkHorizontalPanel> = mainCanvas.GetWidget(n"list_left") as inkHorizontalPanel;
  listLeft.SetAnchor(inkEAnchor.LeftFillVerticaly);
  listLeft.SetAnchorPoint(new Vector2(0.0, 1.0));
  listLeft.SetVAlign(inkEVerticalAlign.Bottom);
  listLeft.SetPadding(new inkMargin(0.0, 24.0, 0.0, 0.0));
  listLeft.SetMargin(new inkMargin(86.0, 0.0, 0.0, 0.0));

  let listBottom: ref<inkHorizontalPanel> = mainCanvas.GetWidget(n"list_bottom") as inkHorizontalPanel;
  listBottom.SetAnchor(inkEAnchor.LeftFillVerticaly);
  listBottom.SetAnchorPoint(new Vector2(0.0, 1.0));
  listBottom.SetVAlign(inkEVerticalAlign.Bottom);
  listBottom.SetPadding(new inkMargin(0.0, 0.0, 0.0, 0.0));
  listBottom.SetMargin(new inkMargin(0.0, 0.0, 72.0, 0.0));
}