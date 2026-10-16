coUnit.TEST('AnalogInput_Scale_20mA_ReturnsRangeHi');

stCfg.rRangeLo_eu := 2.0;
stCfg.rRangeHi_eu := 12.0;
fbAi(itfTime := fbTime, rIn := 20.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 12.0, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'range high at 20 mA');
AssertEquals_REAL(Expected := 100.0, Actual := fbAi.rValue_pct, Delta := 1.0E-4, Message := '100 % at 20 mA');
AssertEquals_REAL(Expected := 100.0, Actual := fbAi.stSts.rValue_pct, Delta := 0.0, Message := 'percent in Sts');
AssertTrue(Condition := fbAi.xValid, Message := 'value valid');

coUnit.TEST_FINISHED();
