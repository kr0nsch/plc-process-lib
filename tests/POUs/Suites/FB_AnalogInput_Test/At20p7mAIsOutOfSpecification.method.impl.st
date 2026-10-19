coUnit.TEST('AnalogInput_At20p7mA_IsOutOfSpecification');

stCfg.tFailDelay := T#0S;
fbAi(itfTime := fbTime, rIn := 20.7, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.OverRange, Message := '20.7 mA is OverRange');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.OutOfSpecification, Message := 'out of specification');
AssertFalse(Condition := fbAi.xValid, Message := 'confirmed out of range: invalid for control');
AssertEquals_REAL(Expected := 103.125, Actual := fbAi.rValue_eu, Delta := 1.0E-4,
                  Message := 'saturation value, no extrapolation');
AssertEquals_WORD(Expected := GVL_Const.AI_WRN_OVER_RANGE, Actual := fbAi.stSts.stCommon.wWarning,
                  Message := 'over range warning');

coUnit.TEST_FINISHED();
