import LimitedHudConfig.LHUDAddonsConfig

// kudos to psiberx for redscript snippets

/*
  Available keybind names and related hotkeys:
    "restore_default_settings" for 'F1' hotkey
    "UI_Unequip" for 'U' hotkey
*/

public static func KeybindName_ToggleHUD() -> String = "restore_default_settings"

public class ToggleHudEvent extends Event {}

public class SimpleToggleGlobalInputListener {

    private let m_uiSystem: ref<UISystem>;
    private let m_config: ref<LHUDAddonsConfig>;

    public func SetUISystem(system: ref<UISystem>) -> Void {
      this.m_uiSystem = system;
    }

    public func SetConfig(m_config: ref<LHUDAddonsConfig>) -> Void {
      this.m_config = m_config;
    }

    protected cb func OnAction(action: ListenerAction, consumer: ListenerActionConsumer) -> Bool {
        if this.m_config.EnableHUDToggle && ListenerAction.IsAction(action, StringToName(KeybindName_ToggleHUD())) && Equals(ListenerAction.GetType(action), gameinputActionType.BUTTON_RELEASED)  {
          this.m_uiSystem.QueueEvent(new ToggleHudEvent());
        };
    }
}

@addMethod(inkGameController)
protected cb func OnToggleHud(evt: ref<ToggleHudEvent>) -> Bool {
  let isVisible: Bool;
  if this.IsA(n"gameuiRootHudGameController") {
    isVisible = this.GetRootWidget().IsVisible();
    this.GetRootWidget().SetVisible(!isVisible);
  };
}

@addField(PlayerPuppet)
private let m_simpleToggleInputListener: ref<SimpleToggleGlobalInputListener>;

@wrapMethod(PlayerPuppet)
protected cb func OnGameAttached() -> Bool {
    wrappedMethod();
    this.m_simpleToggleInputListener = new SimpleToggleGlobalInputListener();
    this.m_simpleToggleInputListener.SetUISystem(GameInstance.GetUISystem(this.GetGame()));
    this.m_simpleToggleInputListener.SetConfig(new LHUDAddonsConfig());
    this.RegisterInputListener(this.m_simpleToggleInputListener);
}

@wrapMethod(PlayerPuppet)
protected cb func OnDetach() -> Bool {
    wrappedMethod();
    this.UnregisterInputListener(this.m_simpleToggleInputListener);
    this.m_simpleToggleInputListener = null;
}
