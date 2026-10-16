coUnit.TEST('AnalogInput_LimitOrderInvalidAtRuntime_KeepsLastValidCfg');

stCfg.eInput := E_AiInputType.Eng;
stCfg.tFailDelay := T#0S;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.H, xEnable := TRUE, rSp_eu := 80.0, rHyst_eu := 1.0, tOnDly := T#0S,
         tOffDly := T#0S);
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.HH, xEnable := TRUE, rSp_eu := 90.0, rHyst_eu := 1.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 85.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.xH AND NOT fbAi.xHH, Message := 'H only at 85');
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.HH, xEnable := TRUE, rSp_eu := 70.0, rHyst_eu := 1.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 85.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_LIMIT_ORDER, Actual := fbAi.stSts.stCommon.wCfgErr,
                  Message := 'limit order bit');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction');
AssertFalse(Condition := fbAi.xHH, Message := 'HH by last valid Cfg (90), not 70');
AssertTrue(Condition := fbAi.xValid, Message := 'value still valid');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 95.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.xHH, Message := 'HH at 95 by last valid Cfg');
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.HH, xEnable := TRUE, rSp_eu := 92.0, rHyst_eu := 1.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 85.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wCfgErr, Message := 'fixed Cfg accepted');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Good, Message := 'good again');

coUnit.TEST_FINISHED();
