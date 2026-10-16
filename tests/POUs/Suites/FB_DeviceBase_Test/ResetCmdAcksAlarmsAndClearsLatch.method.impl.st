coUnit.TEST('Device_ResetCmd_AcksAlarmsAndClearsLatch');

fbDev.axCondIn[0] := TRUE;
fbDev(xFaultCause := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbDev(xFaultCause := FALSE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Fault, Message := 'fault latched');
AssertEquals_WORD(Expected := 16#0001, Actual := fbDev.stSts.stCommon.wAlmUnack, Message := 'alarm unacknowledged');
stCmd.stCommon.xReset := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := fbDev.Fault, Message := 'fault cleared');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmUnack, Message := 'alarms acknowledged by reset');
AssertFalse(Condition := stCmd.stCommon.xReset, Message := 'xReset cleared');
AssertEquals_UINT(Expected := 1, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'reset is one command');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'reset accepted');
fbDev.axCondIn[1] := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 16#0002, Actual := fbDev.stSts.stCommon.wAlmUnack, Message := 'new alarm in slot 1');
xRet := fbDev.Reset();
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := xRet, Message := 'Reset() request accepted');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmUnack,
                  Message := 'Reset() acknowledges all alarms too');
AssertEquals_UINT(Expected := 2, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'Reset() is one command');

coUnit.TEST_FINISHED();
