coUnit.TEST('AnalogInput_At20p7mA_IsOutOfSpecification');

stCfg.tFailDelay := T#0S;
fbAi(itfTime := fbTime, rIn := 20.7, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.OverRange, Message := '20.7 mA is OverRange');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.OutOfSpecification, Message := 'out of specification');
AssertTrue(Condition := fbAi.xValid, Message := 'value still valid');
AssertEquals_REAL(Expected := 104.375, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'extrapolated value');
AssertEquals_WORD(Expected := GVL_Const.AI_WRN_OVER_RANGE, Actual := fbAi.stSts.stCommon.wWarning,
                  Message := 'over range warning');

coUnit.TEST_FINISHED();
