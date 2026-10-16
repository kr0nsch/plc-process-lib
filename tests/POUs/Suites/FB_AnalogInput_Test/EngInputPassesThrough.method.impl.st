coUnit.TEST('AnalogInput_EngInput_PassesThrough');

stCfg.eInput := E_AiInputType.Eng;
stCfg.rRangeLo_eu := -50.0;
stCfg.rRangeHi_eu := 150.0;
stCfg.tFailDelay := T#0S;
fbAi(itfTime := fbTime, rIn := 123.4, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 123.4, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'value passes through');
AssertEquals_REAL(Expected := 86.7, Actual := fbAi.rValue_pct, Delta := 1.0E-4, Message := 'percent of -50..150');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.Good, Message := 'no NE 43 for Eng');
AssertTrue(Condition := fbAi.xValid, Message := 'zero is a valid value');
AssertEquals_REAL(Expected := 25.0, Actual := fbAi.rValue_pct, Delta := 1.0E-4, Message := '0 is 25 % of -50..150');

coUnit.TEST_FINISHED();
