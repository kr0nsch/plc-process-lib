coUnit.TEST('AnalogInput_LimitH_Hysteresis_ClearsBelowSpMinusHyst');

stCfg.eInput := E_AiInputType.Eng;
stCfg.tFailDelay := T#0S;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.H, xEnable := TRUE, rSp_eu := 80.0, rHyst_eu := 2.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 79.9, stCmd := stCmd, stCfg := stCfg);
AssertFalse(Condition := fbAi.xH, Message := 'no H below setpoint');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 80.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.xH, Message := 'H at setpoint');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.AI_STS_H) <> 0, Message := 'H status bit');
itfAlm := fbAi.GetAlarm(uiIndex := E_AiAlarm.H);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'H alarm');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 78.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.xH, Message := 'H kept at setpoint minus hysteresis');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 77.9, stCmd := stCmd, stCfg := stCfg);
AssertFalse(Condition := fbAi.xH, Message := 'H cleared below setpoint minus hysteresis');

coUnit.TEST_FINISHED();
