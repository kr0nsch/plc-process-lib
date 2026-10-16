coUnit.TEST('AnalogInput_WireBreak_SetsFailureAfterDelay');

stCfg.rRangeHi_eu := 5.0;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.LL, xEnable := TRUE, rSp_eu := 0.5, rHyst_eu := 0.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t0: 50 % = 2,5 м
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);   // t1 = t0 + 0,1 с: обрыв
FOR iStep := 1 TO 19 DO   // t1 + 1,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertFalse(Condition := fbAi.Fault, Message := 'no failure before tFailDelay');
AssertEquals_REAL(Expected := 2.5, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'last good value held');
AssertFalse(Condition := fbAi.xLL, Message := 'no false LL on wire break');
AssertTrue(Condition := fbAi.xValid, Message := 'value still valid while failure is pending');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.AI_STS_FAIL_PENDING) <> 0,
           Message := 'fail pending bit');
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.FailLow, Message := 'instant classification FailLow');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);   // t1 + 2,0 с
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Failure, Message := 'failure after 2 s');
AssertFalse(Condition := fbAi.xValid, Message := 'value invalid after confirmed failure');
AssertEquals_WORD(Expected := GVL_Const.AI_FLT_FAIL_LOW, Actual := fbAi.stSts.stCommon.wFault,
                  Message := 'fault bit FAIL_LOW');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.AI_STS_SIGNAL_FAIL) <> 0, Message := 'fail bit');
AssertFalse(Condition := fbAi.xLL, Message := 'LL forced off on failure');
itfAlm := fbAi.GetAlarm(uiIndex := E_AiAlarm.Failure);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'failure alarm annunciated');

coUnit.TEST_FINISHED();
