coUnit.TEST('AnalogInput_NaNInput_TreatedAsFailure');

stCfg.tFailDelay := T#1S;
stCfg.tFilter := T#5S;
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t0: 50
uBits.dwValue := 16#7FC00000;                                     // тихий NaN
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := uBits.rValue, stCmd := stCmd, stCfg := stCfg);   // t1 = t0 + 0,1 с
FOR iStep := 1 TO 9 DO   // t1 + 0,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := uBits.rValue, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.NotFinite, Message := 'NaN is NotFinite');
AssertFalse(Condition := fbAi.Fault, Message := 'no failure before tFailDelay');
AssertEquals_REAL(Expected := 50.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'value held, not NaN');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := uBits.rValue, stCmd := stCmd, stCfg := stCfg);   // t1 + 1,0 с
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Failure, Message := 'failure after tFailDelay');
AssertEquals_WORD(Expected := GVL_Const.AI_FLT_NOT_FINITE, Actual := fbAi.stSts.stCommon.wFault,
                  Message := 'NOT_FINITE fault bit');
uBits.dwValue := 16#7F800000;                                     // +Inf
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := uBits.rValue, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.NotFinite, Message := '+Inf is NotFinite');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 1.0E31, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.NotFinite, Message := 'above REAL_SANE_MAX is NotFinite');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);   // tr: сигнал вернулся, 75
FOR iStep := 1 TO 10 DO   // tr + 1,0 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertFalse(Condition := fbAi.Fault, Message := 'failure cleared');
AssertTrue(Condition := F_IsFinite(rIn := fbAi.rValue_eu), Message := 'value is finite');
AssertEquals_REAL(Expected := 75.0, Actual := fbAi.rValue_eu, Delta := 1.0E-3,
                  Message := 'NaN did not enter the filter');

coUnit.TEST_FINISHED();
