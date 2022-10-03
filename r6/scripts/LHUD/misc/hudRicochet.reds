import LimitedHudConfig.LHUDAddonsColoringConfig
import LimitedHudCommon.LHUDRicochetColors

// No color (disable): 0    Green: 1    Red: 2
@replaceMethod(gameEffectExecutor_Ricochet)
public final func OnSnap(ctx: EffectScriptContext, entity: ref<Entity>) -> Void {
  let data: OutlineData;
  let evt: ref<OutlineRequestEvent> = new OutlineRequestEvent();
  let config: ref<LHUDAddonsColoringConfig> = new LHUDAddonsColoringConfig();
  switch config.RicochetColor {
    case 0: 
      data.outlineType = EOutlineType.NONE;
      break;
    case 1: 
      data.outlineType = EOutlineType.GREEN;
      break;
    case 2: 
      data.outlineType = EOutlineType.RED;
      break;
    default: 
      data.outlineType = EOutlineType.GREEN;
      break;
  }

  data.outlineOpacity = 1.0;
  let id: CName = n"gameEffectExecutor_Ricochet";
  evt.outlineRequest = OutlineRequest.CreateRequest(id, data);
  entity.QueueEvent(evt);
}
