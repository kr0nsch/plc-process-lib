coUnit.TEST('DigitalInput_ResetCmd_AcceptedAndAcksAlarms');

fbDi(itfTime := fbTime, xIn := FALSE, xChannelFault := TRUE, stCmd := stCmd, stCfg := stCfg);
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, xChannelFault := FALSE, stCmd := stCmd, stCfg := stCfg);
itfAlm := fbDi.GetAlarm(uiIndex := E_DiAlarm.Failure);
AssertTrue(Condition := itfAlm.State = E_AlarmState.RtnUnack, Message := 'returned unacknowledged');
uiSeq := fbDi.stSts.stCommon.uiCmdSeq;
stCmd.stCommon.xReset := TRUE;
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbDi.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'reset accepted');
AssertEquals_UINT(Expected := uiSeq + 1, Actual := fbDi.stSts.stCommon.uiCmdSeq, Message := 'one command');
AssertFalse(Condition := stCmd.stCommon.xReset, Message := 'reset bit cleared');
AssertTrue(Condition := itfAlm.State = E_AlarmState.Normal, Message := 'alarm acknowledged');

coUnit.TEST_FINISHED();
