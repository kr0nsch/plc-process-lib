coUnit.TEST('AnalogInput_LimitDisabled_NeverSets');

stCfg.eInput := E_AiInputType.Eng;
stCfg.tFailDelay := T#0S;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.HH, xEnable := FALSE, rSp_eu := 10.0, rHyst_eu := 0.0, tOnDly := T#0S,
         tOffDly := T#0S);
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.LL, xEnable := FALSE, rSp_eu := 90.0, rHyst_eu := 0.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stCfg);
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stCfg);
    xEverSet := xEverSet OR fbAi.xHH OR fbAi.xLL;
END_FOR
AssertFalse(Condition := xEverSet, Message := 'disabled limits never set');
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wCfgErr, Message := 'disabled limits are not checked');
itfAlm := fbAi.GetAlarm(uiIndex := E_AiAlarm.HH);
AssertTrue(Condition := itfAlm.State = E_AlarmState.Normal, Message := 'HH alarm normal');

coUnit.TEST_FINISHED();
