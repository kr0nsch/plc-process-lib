coUnit.TEST('Device_AckMask_AcksOnlySelectedSlot');

fbDev.axCondIn[0] := TRUE;
fbDev.axCondIn[1] := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.stCommon.wAckReq := 16#0002;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 16#0001, Actual := fbDev.stSts.stCommon.wAlmUnack,
                  Message := 'only slot 0 unacknowledged');
itfAlm := fbDev.GetAlarm(uiIndex := 1);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveAck, Message := 'slot 1 acknowledged');
itfAlm := fbDev.GetAlarm(uiIndex := 0);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'slot 0 untouched');
AssertEquals_WORD(Expected := 0, Actual := stCmd.stCommon.wAckReq, Message := 'mask cleared');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'mask accepted');

coUnit.TEST_FINISHED();
