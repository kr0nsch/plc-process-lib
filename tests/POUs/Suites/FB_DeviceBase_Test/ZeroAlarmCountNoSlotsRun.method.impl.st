coUnit.TEST('Device_ZeroAlarmCount_NoSlotsRun');

FOR uiSlot := 0 TO 7 DO
    fbDev.axCondIn[uiSlot] := TRUE;
END_FOR
stCmd.stCommon.wAckReq := 16#FFFF;
fbDev(uiAlarmSlots := 0, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := 0, Actual := fbDev.AlarmCount, Message := 'no alarm slots');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmActive, Message := 'no active alarms');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmUnack, Message := 'no unacknowledged alarms');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'ack mask accepted');
itfAlm := fbDev.GetAlarm(uiIndex := 0);
AssertTrue(Condition := itfAlm = 0, Message := 'GetAlarm(0) = 0');
stCmd.stCommon.wShelveReq := 16#FFFF;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.RejectedState,
           Message := 'shelve mask: no slot accepted');

coUnit.TEST_FINISHED();
