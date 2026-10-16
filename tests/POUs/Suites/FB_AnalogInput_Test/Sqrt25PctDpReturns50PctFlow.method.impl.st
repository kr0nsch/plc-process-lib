coUnit.TEST('AnalogInput_Sqrt_25PctDp_Returns50PctFlow');

stCfg.xSqrt := TRUE;
fbAi(itfTime := fbTime, rIn := 8.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 50.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := '25 % dp -> 50 % flow');
AssertEquals_REAL(Expected := 50.0, Actual := fbAi.rValue_pct, Delta := 1.0E-4, Message := 'percent');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 20.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 100.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'full scale');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 4.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 0.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'zero');

coUnit.TEST_FINISHED();
