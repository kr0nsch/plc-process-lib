coUnit.TEST('AnalogInput_StartupWireBreak_InvalidUntilFirstGoodValue');

stCfg.rRangeHi_eu := 5.0;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.LL, xEnable := TRUE, rSp_eu := 0.5, rHyst_eu := 0.1, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);   // t0: обрыв с первого вызова
AssertFalse(Condition := fbAi.xValid, Message := 'nothing to hold: invalid at once');
AssertEquals_REAL(Expected := 0.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'no good value yet');
AssertFalse(Condition := fbAi.xLL, Message := 'no false LL at startup');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Good, Message := 'failure not yet confirmed');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.AI_STS_FAIL_PENDING) = 0,
           Message := 'no pending bit: nothing is held');
FOR iStep := 1 TO 20 DO   // t0 + 2,0 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.Fault, Message := 'failure confirmed');
FOR iStep := 1 TO 1 DO   // tr: сигнал вернулся
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
FOR iStep := 1 TO 20 DO   // tr + 2,0 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertFalse(Condition := fbAi.Fault, Message := 'failure cleared');
AssertTrue(Condition := fbAi.xValid, Message := 'valid');
AssertEquals_REAL(Expected := 3.75, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'measured value');

coUnit.TEST_FINISHED();
