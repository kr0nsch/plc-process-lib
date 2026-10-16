coUnit.TEST('AnalogInput_At21mA_IsFailure');

stCfg.tFailDelay := T#0S;
fbAi(itfTime := fbTime, rIn := 21.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.FailHigh, Message := '21 mA is FailHigh');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Failure, Message := 'failure at 21 mA');
AssertEquals_WORD(Expected := GVL_Const.AI_FLT_FAIL_HIGH, Actual := fbAi.stSts.stCommon.wFault, Message := 'FAIL_HIGH');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 20.99, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.OverRange, Message := '20.99 mA is OverRange');

coUnit.TEST_FINISHED();
