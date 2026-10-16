coUnit.TEST('Device_GetAlarmOutOfRange_ReturnsNull');

itfAlm := fbDev.GetAlarm(uiIndex := 0);
AssertTrue(Condition := itfAlm = 0, Message := 'no slots before the first call');
AssertEquals_UINT(Expected := 0, Actual := fbDev.AlarmCount, Message := 'AlarmCount 0 before the first call');
fbDev(uiAlarmSlots := 3, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := 3, Actual := fbDev.AlarmCount, Message := 'AlarmCount set by the heir');
itfAlm := fbDev.GetAlarm(uiIndex := 2);
AssertTrue(Condition := itfAlm <> 0, Message := 'slot 2 exists');
itfAlm := fbDev.GetAlarm(uiIndex := 3);
AssertTrue(Condition := itfAlm = 0, Message := 'slot 3 is not used: null');
itfAlm := fbDev.GetAlarm(uiIndex := 65535);
AssertTrue(Condition := itfAlm = 0, Message := 'index 65535: null');

coUnit.TEST_FINISHED();
