coUnit.TEST('AnalogInput_Filter_OneTimeConstant_Reaches63Pct');

stCfg.tFilter := T#10S;
fbAi(itfTime := fbTime, rIn := 4.0, stCmd := stCmd, stCfg := stCfg);   // t0: фильтр начат с 0
FOR iStep := 1 TO 99 DO   // ступень 100 %, t0 + 9,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 20.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertEquals_REAL(Expected := 62.84233, Actual := fbAi.rValue_eu, Delta := 1.0E-3, Message := '62.84 at 9.9 s');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 20.0, stCmd := stCmd, stCfg := stCfg);   // t0 + 10,0 с
AssertEquals_REAL(Expected := 63.21206, Actual := fbAi.rValue_eu, Delta := 1.0E-3, Message := '63.2 % after one T');

coUnit.TEST_FINISHED();
