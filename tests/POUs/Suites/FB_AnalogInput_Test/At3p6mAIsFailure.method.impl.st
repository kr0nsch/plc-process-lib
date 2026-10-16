coUnit.TEST('AnalogInput_At3p6mA_IsFailure');

stCfg.tFailDelay := T#0S;
fbAi(itfTime := fbTime, rIn := 3.6, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.FailLow, Message := '3.6 mA is FailLow');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Failure, Message := 'failure at 3.6 mA');
AssertEquals_WORD(Expected := GVL_Const.AI_FLT_FAIL_LOW, Actual := fbAi.stSts.stCommon.wFault, Message := 'FAIL_LOW');
AssertFalse(Condition := fbAi.xValid, Message := 'invalid');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 3.61, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.UnderRange, Message := '3.61 mA is UnderRange');

coUnit.TEST_FINISHED();
