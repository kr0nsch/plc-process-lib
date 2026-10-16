coUnit.TEST('AnalogInput_LimitL_Hysteresis_ClearsAboveSpPlusHyst');

stCfg.eInput := E_AiInputType.Eng;
stCfg.tFailDelay := T#0S;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.L, xEnable := TRUE, rSp_eu := 20.0, rHyst_eu := 2.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 20.1, stCmd := stCmd, stCfg := stCfg);
AssertFalse(Condition := fbAi.xL, Message := 'no L above setpoint');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 20.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.xL, Message := 'L at setpoint');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 22.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.xL, Message := 'L kept at setpoint plus hysteresis');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 22.1, stCmd := stCmd, stCfg := stCfg);
AssertFalse(Condition := fbAi.xL, Message := 'L cleared above setpoint plus hysteresis');

coUnit.TEST_FINISHED();
