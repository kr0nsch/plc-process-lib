coUnit.TEST('Device_AckAll_AcksEveryAlarm');

fbDev.axCondIn[0] := TRUE;
fbDev.axCondIn[1] := TRUE;
fbDev.axCondIn[2] := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 16#0007, Actual := fbDev.stSts.stCommon.wAlmUnack,
                  Message := 'three unacknowledged alarms');
AssertEquals_WORD(Expected := GVL_Const.DEV_STS_ALARM_UNACK,
                  Actual := fbDev.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_ALARM_UNACK, Message := 'unack bit set');
xRet := fbDev.AckAll();
AssertTrue(Condition := xRet, Message := 'AckAll returns TRUE: there is something to acknowledge');
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmUnack, Message := 'all acknowledged');
AssertEquals_WORD(Expected := 16#0007, Actual := fbDev.stSts.stCommon.wAlmActive, Message := 'still active');
itfAlm := fbDev.GetAlarm(uiIndex := 2);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveAck, Message := 'slot 2 ActiveAck');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_ALARM_UNACK,
                  Message := 'unack bit cleared');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'AckAll accepted');
AssertEquals_UINT(Expected := 1, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'AckAll is a command');
xRet := fbDev.AckAll();
AssertFalse(Condition := xRet, Message := 'AckAll returns FALSE: nothing to acknowledge');
fbDev.axCondIn[3] := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 16#0008, Actual := fbDev.stSts.stCommon.wAlmUnack, Message := 'new alarm in slot 3');
stCmd.stCommon.xAck := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmUnack, Message := 'xAck acknowledges all');
AssertFalse(Condition := stCmd.stCommon.xAck, Message := 'xAck cleared');
AssertEquals_UINT(Expected := 3, Actual := fbDev.stSts.stCommon.uiCmdSeq,
                  Message := 'each acknowledge request counted');

coUnit.TEST_FINISHED();
