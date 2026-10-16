coUnit.TEST('AnalogInput_At3p8mA_IsGood');

stCfg.tFailDelay := T#0S;
fbAi(itfTime := fbTime, rIn := 3.8, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.Good, Message := '3.8 mA is good');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Good, Message := 'NE 107 good');
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wWarning, Message := 'no warning');
AssertEquals_REAL(Expected := -1.25, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := '-1.25 % at 3.8 mA');

coUnit.TEST_FINISHED();
