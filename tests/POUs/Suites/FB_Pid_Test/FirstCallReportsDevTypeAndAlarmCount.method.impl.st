coUnit.TEST('Pid_FirstCall_ReportsDevTypeAndAlarmCount');
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbPid.stSts.stCommon.eDevType = E_DeviceType.Pid, Message := 'eDevType = Pid');
AssertEquals_UINT(Expected := GVL_Const.PID_ALARM_COUNT, Actual := fbPid.AlarmCount, Message := 'one alarm slot');
AssertEquals_UINT(Expected := TO_UINT(E_PidAlarm.PvInvalid) + 1, Actual := fbPid.AlarmCount,
                  Message := 'slot count matches E_PidAlarm');
AssertTrue(Condition := fbPid.Mode = E_DeviceMode.Manual, Message := 'Manual from default retain');
AssertFalse(Condition := fbPid.RequestMode(eNewMode := E_DeviceMode.Local), Message := 'Local not requestable');
coUnit.TEST_FINISHED();
