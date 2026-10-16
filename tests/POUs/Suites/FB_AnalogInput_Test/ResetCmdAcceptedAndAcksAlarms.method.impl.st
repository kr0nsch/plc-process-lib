coUnit.TEST('AnalogInput_ResetCmd_AcceptedAndAcksAlarms');

stCfg.tFailDelay := T#0S;
fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);   // отказ
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // вернулся: RtnUnack
itfAlm := fbAi.GetAlarm(uiIndex := E_AiAlarm.Failure);
AssertTrue(Condition := itfAlm.State = E_AlarmState.RtnUnack, Message := 'returned unacknowledged');
uiSeq := fbAi.stSts.stCommon.uiCmdSeq;
stCmd.stCommon.xReset := TRUE;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'reset accepted');
AssertEquals_UINT(Expected := uiSeq + 1, Actual := fbAi.stSts.stCommon.uiCmdSeq, Message := 'one command');
AssertFalse(Condition := stCmd.stCommon.xReset, Message := 'reset bit cleared');
AssertTrue(Condition := itfAlm.State = E_AlarmState.Normal, Message := 'alarm acknowledged');

coUnit.TEST_FINISHED();
