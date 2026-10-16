coUnit.TEST('AnalogInput_At3p7mA_IsOutOfSpecification');

stCfg.tFailDelay := T#0S;
fbAi(itfTime := fbTime, rIn := 3.7, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.UnderRange, Message := '3.7 mA is UnderRange');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.OutOfSpecification, Message := 'out of specification');
AssertTrue(Condition := fbAi.xValid, Message := 'value still valid');
AssertEquals_REAL(Expected := -1.875, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'extrapolated value');
AssertEquals_WORD(Expected := GVL_Const.AI_WRN_UNDER_RANGE, Actual := fbAi.stSts.stCommon.wWarning,
                  Message := 'under range warning');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_WARNING) <> 0, Message := 'warning bit');
itfAlm := fbAi.GetAlarm(uiIndex := E_AiAlarm.OutOfRange);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'out of range alarm');

coUnit.TEST_FINISHED();
