coUnit.TEST('AnalogInput_Norm01_NoNe43Check');

stCfg.eInput := E_AiInputType.Norm01;
stCfg.tFailDelay := T#0S;
fbAi(itfTime := fbTime, rIn := -0.03, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.Good, Message := 'no NE 43 classification');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Good, Message := 'no failure, no out of range');
AssertTrue(Condition := fbAi.xValid, Message := 'value valid');
AssertEquals_REAL(Expected := -3.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'extrapolated -3 %');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 0.7, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 70.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := '0.7 -> 70');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 1.5, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 150.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := '1.5 -> 150');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Good, Message := 'still good above full scale');

coUnit.TEST_FINISHED();
