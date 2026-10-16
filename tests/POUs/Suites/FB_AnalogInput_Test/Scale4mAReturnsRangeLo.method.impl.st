coUnit.TEST('AnalogInput_Scale_4mA_ReturnsRangeLo');

stCfg.rRangeLo_eu := 2.0;
stCfg.rRangeHi_eu := 12.0;
fbAi(itfTime := fbTime, rIn := 4.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 2.0, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'range low at 4 mA');
AssertEquals_REAL(Expected := 0.0, Actual := fbAi.rValue_pct, Delta := 1.0E-4, Message := '0 % at 4 mA');
AssertEquals_REAL(Expected := 2.0, Actual := fbAi.stSts.rValue_eu, Delta := 0.0, Message := 'value in Sts');
AssertTrue(Condition := fbAi.xValid, Message := 'value valid');
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.Good, Message := 'signal good');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Good, Message := 'NE 107 good');

coUnit.TEST_FINISHED();
