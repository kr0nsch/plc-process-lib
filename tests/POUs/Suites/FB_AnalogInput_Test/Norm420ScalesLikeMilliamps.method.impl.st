coUnit.TEST('AnalogInput_Norm420_ScalesLikeMilliamps');

stCfg.eInput := E_AiInputType.Norm420;
stCfg.rRangeLo_eu := 2.0;
stCfg.rRangeHi_eu := 12.0;
stCfg.tFailDelay := T#0S;
stCfgMa.rRangeLo_eu := 2.0;
stCfgMa.rRangeHi_eu := 12.0;
fbAi(itfTime := fbTime, rIn := 0.5, stCmd := stCmd, stCfg := stCfg);
fbMa(itfTime := fbTime, rIn := 12.0, stCmd := stCmdMa, stCfg := stCfgMa);
AssertEquals_REAL(Expected := 7.0, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'Norm420 0.5 is mid range');
AssertEquals_REAL(Expected := fbMa.rValue_eu, Actual := fbAi.rValue_eu, Delta := 1.0E-5,
                  Message := 'same value as 12 mA');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := -0.05, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.FailLow, Message := 'NE 43 by I = 4 + 16 * rIn: 3.2 mA');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Failure, Message := 'failure with tFailDelay = 0');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 1.0625, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.FailHigh, Message := '21 mA by I = 4 + 16 * rIn');

coUnit.TEST_FINISHED();
