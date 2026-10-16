coUnit.TEST('AnalogInput_Failure_ForcesLimitsFalseAndSuppressesLimitAlarms');

stCfg.rRangeHi_eu := 5.0;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.H, xEnable := TRUE, rSp_eu := 4.0, rHyst_eu := 0.1, tOnDly := T#0S,
         tOffDly := T#0S);
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.LL, xEnable := TRUE, rSp_eu := 0.5, rHyst_eu := 0.1, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 17.6, stCmd := stCmd, stCfg := stCfg);   // t0: 4,25 м
AssertTrue(Condition := fbAi.xH, Message := 'H active before break');
itfAlm := fbAi.GetAlarm(uiIndex := E_AiAlarm.H);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'H alarm active');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);   // t1 = t0 + 0,1 с: обрыв
FOR iStep := 1 TO 19 DO   // t1 + 1,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.xH, Message := 'H kept on held value while pending');
AssertFalse(Condition := fbAi.xLL, Message := 'no false LL while pending');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);   // t1 + 2,0 с
AssertTrue(Condition := fbAi.Fault, Message := 'failure confirmed');
AssertFalse(Condition := fbAi.xH, Message := 'H forced off');
AssertFalse(Condition := fbAi.xLL, Message := 'LL forced off');
AssertTrue(Condition := itfAlm.State = E_AlarmState.SuppressedByDesign, Message := 'H alarm suppressed');
itfAlm := fbAi.GetAlarm(uiIndex := E_AiAlarm.Failure);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'failure alarm');

coUnit.TEST_FINISHED();
