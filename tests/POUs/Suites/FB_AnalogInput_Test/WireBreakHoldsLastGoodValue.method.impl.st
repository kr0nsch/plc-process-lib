coUnit.TEST('AnalogInput_WireBreak_HoldsLastGoodValue');

stCfg.rRangeHi_eu := 5.0;
fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);   // t0: 75 % = 3,75
FOR iStep := 1 TO 10 DO   // обрыв, t0 + 1,0 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertEquals_REAL(Expected := 3.75, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'held while pending');
FOR iStep := 1 TO 20 DO   // t0 + 3,0 с: отказ подтверждён
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.Fault, Message := 'failure confirmed');
AssertEquals_REAL(Expected := 3.75, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'held after confirmation');
AssertEquals_REAL(Expected := 75.0, Actual := fbAi.rValue_pct, Delta := 1.0E-4, Message := 'percent of held value');
AssertEquals_REAL(Expected := 3.75, Actual := stCmd.rSubstValue_eu, Delta := 0.0, Message := 'tracking of held value');
AssertFalse(Condition := fbAi.xValid, Message := 'held value is not valid');

coUnit.TEST_FINISHED();
