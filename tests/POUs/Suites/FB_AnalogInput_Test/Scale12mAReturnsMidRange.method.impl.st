coUnit.TEST('AnalogInput_Scale_12mA_ReturnsMidRange');

stCfg.rRangeLo_eu := 2.0;
stCfg.rRangeHi_eu := 12.0;
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 7.0, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'mid range at 12 mA');
AssertEquals_REAL(Expected := 50.0, Actual := fbAi.rValue_pct, Delta := 1.0E-4, Message := '50 % at 12 mA');
AssertEquals_REAL(Expected := 12.0, Actual := fbAi.stSts.rIn, Delta := 0.0, Message := 'raw input in Sts');

coUnit.TEST_FINISHED();
