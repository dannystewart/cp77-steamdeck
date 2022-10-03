module LimitedHudConfig
import LimitedHudCommon.*

public class ActionButtonsModuleConfig {
  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Action-Buttons")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Is-Enabled")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Is-Enabled-Desc")
  let IsEnabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Action-Buttons")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Global-Key")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Global-Key-Desc")
  let BindToGlobalHotkey: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Action-Buttons")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Combat-Desc")
  let ShowInCombat: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Action-Buttons")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Out-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Out-Combat-Desc")
  let ShowOutOfCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Action-Buttons")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Stealth")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Stealth-Desc")
  let ShowInStealth: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Action-Buttons")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Weapon")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Weapon-Desc")
  let ShowWithWeapon: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Action-Buttons")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Zoom")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Zoom-Desc")
  let ShowWithZoom: Bool = false;
}

public class CrouchIndicatorModuleConfig {
  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Crouch-Indicator")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Is-Enabled")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Is-Enabled-Desc")
  let IsEnabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Crouch-Indicator")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Global-Key")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Global-Key-Desc")
  let BindToGlobalHotkey: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Crouch-Indicator")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Combat-Desc")
  let ShowInCombat: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Crouch-Indicator")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Out-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Out-Combat-Desc")
  let ShowOutOfCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Crouch-Indicator")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Stealth")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Stealth-Desc")
  let ShowInStealth: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Crouch-Indicator")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Weapon")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Weapon-Desc")
  let ShowWithWeapon: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Crouch-Indicator")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Zoom")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Zoom-Desc")
  let ShowWithZoom: Bool = false;
}

public class WeaponRosterModuleConfig {
  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Weapon-Roster")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Is-Enabled")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Is-Enabled-Desc")
  let IsEnabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Weapon-Roster")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Global-Key")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Global-Key-Desc")
  let BindToGlobalHotkey: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Weapon-Roster")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Combat-Desc")
  let ShowInCombat: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Weapon-Roster")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Out-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Out-Combat-Desc")
  let ShowOutOfCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Weapon-Roster")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Stealth")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Stealth-Desc")
  let ShowInStealth: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Weapon-Roster")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Weapon")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Weapon-Desc")
  let ShowWithWeapon: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Weapon-Roster")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Zoom")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Zoom-Desc")
  let ShowWithZoom: Bool = false;
}

public class HintsModuleConfig {
  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Hotkey-Hints")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Is-Enabled")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Is-Enabled-Desc")
  let IsEnabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Hotkey-Hints")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Global-Key")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Global-Key-Desc")
  let BindToGlobalHotkey: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Hotkey-Hints")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Combat-Desc")
  let ShowInCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Hotkey-Hints")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Out-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Out-Combat-Desc")
  let ShowOutOfCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Hotkey-Hints")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Stealth")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Stealth-Desc")
  let ShowInStealth: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Hotkey-Hints")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Vehicle")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Vehicle-Desc")
  let ShowInVehicle: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Hotkey-Hints")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Weapon")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Weapon-Desc")
  let ShowWithWeapon: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Hotkey-Hints")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Zoom")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Zoom-Desc")
  let ShowWithZoom: Bool = false;
}

public class MinimapModuleConfig {
  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Minimap")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Is-Enabled")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Is-Enabled-Desc")
  let IsEnabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Minimap")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Global-Key")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Global-Key-Desc")
  let BindToGlobalHotkey: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Minimap")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Combat-Desc")
  let ShowInCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Minimap")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Out-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Out-Combat-Desc")
  let ShowOutOfCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Minimap")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Stealth")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Stealth-Desc")
  let ShowInStealth: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Minimap")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Vehicle")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Vehicle-Desc")
  let ShowInVehicle: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Minimap")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Scanner")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Scanner-Desc")
  let ShowWithScanner: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Minimap")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Weapon")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Weapon-Desc")
  let ShowWithWeapon: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Minimap")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Zoom")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Zoom-Desc")
  let ShowWithZoom: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Minimap")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Minimap-Opacity")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Minimap-Opacity-Desc")
  @runtimeProperty("ModSettings.step", "0.1")
  @runtimeProperty("ModSettings.min", "0.0")
  @runtimeProperty("ModSettings.max", "1.0")
  let Opacity: Float = 0.9;
}

public class QuestTrackerModuleConfig {
  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Quest-Tracker")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Is-Enabled")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Is-Enabled-Desc")
  let IsEnabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Quest-Tracker")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Global-Key")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Global-Key-Desc")
  let BindToGlobalHotkey: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Quest-Tracker")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Combat-Desc")
  let ShowInCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Quest-Tracker")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Out-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Out-Combat-Desc")
  let ShowOutOfCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Quest-Tracker")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Stealth")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Stealth-Desc")
  let ShowInStealth: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Quest-Tracker")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Vehicle")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Vehicle-Desc")
  let ShowInVehicle: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Quest-Tracker")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Scanner")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Scanner-Desc")
  let ShowWithScanner: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Quest-Tracker")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Weapon")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Weapon-Desc")
  let ShowWithWeapon: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Quest-Tracker")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Zoom")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Zoom-Desc")
  let ShowWithZoom: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Quest-Tracker")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Quest-Tracker-Updates")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Quest-Tracker-Updates-Desc")
  let DisplayForQuestUpdates: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Quest-Tracker")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Quest-Tracker-Time")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Quest-Tracker-Time-Desc")
  @runtimeProperty("ModSettings.step", "1.0")
  @runtimeProperty("ModSettings.min", "1.0")
  @runtimeProperty("ModSettings.max", "10.0")
  let QuestUpdateDisplayingTime: Float = 5.0;
}

public class PlayerHealthbarModuleConfig {
  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Healthbar")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Is-Enabled")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Is-Enabled-Desc")
  let IsEnabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Healthbar")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Global-Key")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Global-Key-Desc")
  let BindToGlobalHotkey: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Healthbar")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Player-Healthbar-No-Health")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Player-Healthbar-No-Health-Desc")
  let ShowWhenHealthNotFull: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Healthbar")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Player-Healthbar-No-Memory")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Player-Healthbar-No-Memory-Desc")
  let ShowWhenMemoryNotFull: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Healthbar")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Player-Healthbar-Buffs")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Player-Healthbar-Buffs-Desc")
  let ShowWhenBuffsActive: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Healthbar")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Player-Healthbar-Hacks")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Player-Healthbar-Hacks-Desc")
  let ShowWhenQuickhacksActive: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Healthbar")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Combat-Desc")
  let ShowInCombat: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Healthbar")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Out-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Out-Combat-Desc")
  let ShowOutOfCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Healthbar")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Stealth")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Stealth-Desc")
  let ShowInStealth: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Healthbar")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Weapon")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Weapon-Desc")
  let ShowWithWeapon: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Healthbar")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Zoom")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Zoom-Desc")
  let ShowWithZoom: Bool = false;
}

public class WorldMarkersModuleConfigQuest {
  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Quest")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Is-Enabled")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Is-Enabled-Desc")
  let IsEnabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Quest")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Global-Key")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Global-Key-Desc")
  let BindToGlobalHotkey: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Quest")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Combat-Desc")
  let ShowInCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Quest")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Out-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Out-Combat-Desc")
  let ShowOutOfCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Quest")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Stealth")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Stealth-Desc")
  let ShowInStealth: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Quest")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Vehicle")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Vehicle-Desc")
  let ShowInVehicle: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Quest")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Scanner")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Scanner-Desc")
  let ShowWithScanner: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Quest")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Weapon")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Weapon-Desc")
  let ShowWithWeapon: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Quest")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Zoom")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Zoom-Desc")
  let ShowWithZoom: Bool = true;
}

public class WorldMarkersModuleConfigLoot {
  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Loot")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Is-Enabled")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Is-Enabled-Desc")
  let IsEnabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Loot")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Global-Key")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Global-Key-Desc")
  let BindToGlobalHotkey: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Loot")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Combat-Desc")
  let ShowInCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Loot")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Out-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Out-Combat-Desc")
  let ShowOutOfCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Loot")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Stealth")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Stealth-Desc")
  let ShowInStealth: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Loot")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Vehicle")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Vehicle-Desc")
  let ShowInVehicle: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Loot")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Scanner")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Scanner-Desc")
  let ShowWithScanner: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Loot")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Weapon")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Weapon-Desc")
  let ShowWithWeapon: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Loot")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Zoom")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Zoom-Desc")
  let ShowWithZoom: Bool = true;
}

public class WorldMarkersModuleConfigPOI {
  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-POI")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Is-Enabled")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Is-Enabled-Desc")
  let IsEnabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-POI")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Global-Key")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Global-Key-Desc")
  let BindToGlobalHotkey: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-POI")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Combat-Desc")
  let ShowInCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-POI")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Out-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Out-Combat-Desc")
  let ShowOutOfCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-POI")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Stealth")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Stealth-Desc")
  let ShowInStealth: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-POI")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Vehicle")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Vehicle-Desc")
  let ShowInVehicle: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-POI")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Scanner")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Scanner-Desc")
  let ShowWithScanner: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-POI")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Weapon")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Weapon-Desc")
  let ShowWithWeapon: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-POI")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Zoom")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Zoom-Desc")
  let ShowWithZoom: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-POI")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-POI-Tracked")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-POI-Tracked-Desc")
  let AlwaysShowTrackedMarker: Bool = false;
}

public class WorldMarkersModuleConfigCombat {
  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Combat")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Is-Enabled")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Is-Enabled-Desc")
  let IsEnabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Combat")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Global-Key")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Global-Key-Desc")
  let BindToGlobalHotkey: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Combat")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Combat-Desc")
  let ShowInCombat: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Combat")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Out-Combat")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Out-Combat-Desc")
  let ShowOutOfCombat: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Combat")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Stealth")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Stealth-Desc")
  let ShowInStealth: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Combat")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Vehicle")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Vehicle-Desc")
  let ShowInVehicle: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Combat")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Scanner")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Scanner-Desc")
  let ShowWithScanner: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Combat")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Weapon")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Weapon-Desc")
  let ShowWithWeapon: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Combat")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Zoom")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Zoom-Desc")
  let ShowWithZoom: Bool = false;
}

public class WorldMarkersModuleConfigVehicles {
  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Vehicles")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Is-Enabled")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Is-Enabled-Desc")
  let IsEnabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Vehicles")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Global-Key")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Global-Key-Desc")
  let BindToGlobalHotkey: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Vehicles")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Vehicle")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Vehicle-Desc")
  let ShowInVehicle: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Vehicles")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Scanner")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Scanner-Desc")
  let ShowWithScanner: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Vehicles")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Zoom")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Zoom-Desc")
  let ShowWithZoom: Bool = true;
}

public class WorldMarkersModuleConfigDevices{
  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Devices")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Is-Enabled")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Is-Enabled-Desc")
  let IsEnabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD")
  @runtimeProperty("ModSettings.category", "Mod-LHUD-Player-Markers-Devices")
  @runtimeProperty("ModSettings.displayName", "Mod-LHUD-Show-Scanner")
  @runtimeProperty("ModSettings.description", "Mod-LHUD-Show-Scanner-Desc")
  let ShowWithScanner: Bool = true;
}

public class LHUDAddonsConfig {
  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Journal-Widget")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Opacity")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Opacity-Desc")
  @runtimeProperty("ModSettings.step", "0.1")
  @runtimeProperty("ModSettings.min", "0.0")
  @runtimeProperty("ModSettings.max", "1.0")
  let JournalNotificationOpacity: Float = 1.0;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Journal-Widget")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Scale")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Scale-Desc")
  @runtimeProperty("ModSettings.step", "0.1")
  @runtimeProperty("ModSettings.min", "0.1")
  @runtimeProperty("ModSettings.max", "2.0")
  let JournalNotificationScale: Float = 0.7;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Items-Widget")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Opacity")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Opacity-Desc")
  @runtimeProperty("ModSettings.step", "0.1")
  @runtimeProperty("ModSettings.min", "0.0")
  @runtimeProperty("ModSettings.max", "1.0")
  let ItemNotificationOpacity: Float = 1.0;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Items-Widget")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Scale")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Scale-Desc")
  @runtimeProperty("ModSettings.step", "0.1")
  @runtimeProperty("ModSettings.min", "0.1")
  @runtimeProperty("ModSettings.max", "2.0")
  let ItemNotificationScale: Float = 0.7;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Notification-Sounds")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Notification-Mute-Quest")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Notification-Mute-Quest-Desc")
  let MuteQuestNotifications: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Notification-Sounds")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Notification-Mute-Level")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Notification-Mute-Level-Desc")
  let MuteLevelUpNotifications: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Hide-Prompt")
  @runtimeProperty("ModSettings.displayName", "LocKey#23295")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Hide-Prompt-Vehicle")
  let HidePromptGetIn: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Hide-Prompt")
  @runtimeProperty("ModSettings.displayName", "LocKey#238")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Hide-Prompt-Pick-Up")
  let HidePromptPickUpBody: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Hide-Prompt")
  @runtimeProperty("ModSettings.displayName", "LocKey#312")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Hide-Prompt-Talk")
  let HidePromptTalk: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Widgets-Remover")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Speedometer")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Speedometer-Hide-Desc")
  let HideSpeedometer: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Widgets-Remover")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Crouch")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Crouch-Remove-Desc")
  let HideCrouchIndicator: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Widgets-Remover")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Healthbar-Texts")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Healthbar-Texts-Remove-Desc")
  let RemoveHealthbarTexts: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Widgets-Remover")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Remover-Overhead")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Remover-Overhead-Desc")
  let RemoveOverheadSubtitles: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Widgets-Remover")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-New-Area")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-New-Area-Desc")
  let RemoveNewAreaNotification: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Dialog-Resizer")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Scale")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Scale-Desc")
  @runtimeProperty("ModSettings.step", "0.1")
  @runtimeProperty("ModSettings.min", "0.1")
  @runtimeProperty("ModSettings.max", "2.0")
  let DialogResizerScale: Float = 1.0;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Evolution")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Evolution-Enable")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Evolution-Enable-Desc")
  let FixEvolutionIcons: Bool = true;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Pulse")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Pulse-Disable")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Pulse-Disable-Desc")
  let RemoveMarkerPulse: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-HUD-Toggle")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-HUD-Toggle-Enable")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-HUD-Toggle-Enable-Desc")
  let EnableHUDToggle: Bool = false;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Highlighting")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Highlight-Pinged")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Highlight-Pinged-Desc")
  let HighlightUnderPingOnly: Bool = false;
}

public class LHUDAddonsColoringConfig {
  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Interaction")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Interaction-Fill")
  let FillInteraction: LHUDFillColors = LHUDFillColors.LightBlue;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Imp-Interaction")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Imp-Interaction-Fill")
  let FillImportantInteraction: LHUDFillColors = LHUDFillColors.Blue;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Weakspot")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Weakspot-Fill")
  let FillWeakspot: LHUDFillColors = LHUDFillColors.Orange;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Quest")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Quest-Fill")
  let FillQuest: LHUDFillColors = LHUDFillColors.LightYellow;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Distraction")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Distraction-Fill")
  let FillDistraction: LHUDFillColors = LHUDFillColors.White;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Clue")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Clue-Fill")
  let FillClue: LHUDFillColors = LHUDFillColors.LightGreen;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-NPC")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-NPC-Fill")
  let FillNPC: LHUDFillColors = LHUDFillColors.Transparent;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-AOE")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-AOE-Fill")
  let FillAOE: LHUDFillColors = LHUDFillColors.Red;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Item")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Item-Fill")
  let FillItem: LHUDFillColors = LHUDFillColors.Blue;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Hostile")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Hostile-Fill")
  let FillHostile: LHUDFillColors = LHUDFillColors.Red;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Friendly")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Friendly-Fill")
  let FillFriendly: LHUDFillColors = LHUDFillColors.LightGreen;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Neutral")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Neutral-Fill")
  let FillNeutral: LHUDFillColors = LHUDFillColors.LightBlue;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Hackable")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Hackable-Fill")
  let FillHackable: LHUDFillColors = LHUDFillColors.LightGreen;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Netrunner")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Netrunner-Fill")
  let FillEnemyNetrunner: LHUDFillColors = LHUDFillColors.Orange;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Fill")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Backdoor")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Backdoor-Fill")
  let FillBackdoor: LHUDFillColors = LHUDFillColors.Blue;


  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Interaction")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Interaction-Outline")
  let OutlineInteraction: LHUDOutlineColors = LHUDOutlineColors.LightBlue;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Imp-Interaction")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Imp-Interaction-Outline")
  let OutlineImportantInteraction: LHUDOutlineColors = LHUDOutlineColors.Blue;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Weakspot")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Weakspot-Outline")
  let OutlineWeakspot: LHUDOutlineColors = LHUDOutlineColors.LightRed;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Quest")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Quest-Outline")
  let OutlineQuest: LHUDOutlineColors = LHUDOutlineColors.LightYellow;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Distraction")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Distraction-Outline")
  let OutlineDistraction: LHUDOutlineColors = LHUDOutlineColors.White;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Clue")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Clue-Outline")
  let OutlineClue: LHUDOutlineColors = LHUDOutlineColors.LightGreen;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-AOE")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-AOE-Outline")
  let OutlineAOE: LHUDOutlineColors = LHUDOutlineColors.Red;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Item")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Item-Outline")
  let OutlineItem: LHUDOutlineColors = LHUDOutlineColors.Blue;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Hostile")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Hostile-Outline")
  let OutlineHostile: LHUDOutlineColors = LHUDOutlineColors.Red;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Friendly")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Friendly-Outline")
  let OutlineFriendly: LHUDOutlineColors = LHUDOutlineColors.LightGreen;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Neutral")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Neutral-Outline")
  let OutlineNeutral: LHUDOutlineColors = LHUDOutlineColors.LightBlue;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Hackable")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Hackable-Outline")
  let OutlineHackable: LHUDOutlineColors = LHUDOutlineColors.LightGreen;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Netrunner")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Netrunner-Outline")
  let OutlineEnemyNetrunner: LHUDOutlineColors = LHUDOutlineColors.LightRed;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Outline")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Backdoor")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Backdoor-Outline")
  let OutlineBackdoor: LHUDOutlineColors = LHUDOutlineColors.Blue;

  @runtimeProperty("ModSettings.mod", "LHUD Addons")
  @runtimeProperty("ModSettings.category", "Addons-LHUD-Coloring-Ricochet")
  @runtimeProperty("ModSettings.displayName", "Addons-LHUD-Coloring-Ricochet-NPC")
  @runtimeProperty("ModSettings.description", "Addons-LHUD-Coloring-Ricochet-NPC-Desc")
  let RicochetColor: LHUDRicochetColors = LHUDRicochetColors.Green;
}
