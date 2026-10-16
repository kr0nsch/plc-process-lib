coUnit.TEST('AnalogInput_At20p5mA_IsGood');

stCfg.tFailDelay := T#0S;
fbAi(itfTime := fbTime, rIn := 20.5, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.Good, Message := '20.5 mA is good');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Good, Message := 'NE 107 good');
AssertEquals_REAL(Expected := 103.125, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := '103.125 % at 20.5 mA');

coUnit.TEST_FINISHED();
