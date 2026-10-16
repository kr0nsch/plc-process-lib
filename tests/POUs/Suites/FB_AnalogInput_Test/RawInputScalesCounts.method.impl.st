coUnit.TEST('AnalogInput_RawInput_ScalesCounts');

stCfg.eInput := E_AiInputType.Raw;
stCfg.rRangeHi_eu := 16.0;
stCfg.rRawLo_cnt := 2000.0;
stCfg.rRawHi_cnt := 10000.0;
fbAi(itfTime := fbTime, rIn := 6000.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wCfgErr, Message := 'raw range is valid');
AssertEquals_REAL(Expected := 8.0, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := '6000 counts -> 8 bar');
AssertEquals_REAL(Expected := 50.0, Actual := fbAi.rValue_pct, Delta := 1.0E-4, Message := 'mid scale');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 1000.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := -2.0, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'below raw low extrapolates');
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.Good, Message := 'no NE 43 for Raw');

coUnit.TEST_FINISHED();
