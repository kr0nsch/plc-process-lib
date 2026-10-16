coUnit.TEST('Device_AlarmsInOos_AllSlotsOutOfService');

fbDev.axCondIn[0] := TRUE;
fbDev(uiAlarmSlots := 3, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.stCommon.xSetOos := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
itfAlm := fbDev.GetAlarm(uiIndex := 2);
AssertTrue(Condition := itfAlm.State = E_AlarmState.OutOfService, Message := 'slot 2 OutOfService');
itfAlm := fbDev.GetAlarm(uiIndex := 0);
AssertTrue(Condition := itfAlm.State = E_AlarmState.OutOfService, Message := 'active slot 0 OutOfService');
AssertEquals_WORD(Expected := 16#0007, Actual := fbDev.stSts.stCommon.wAlmShelved, Message := 'three used slots');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmUnack, Message := 'no unacknowledged alarms');
AssertEquals_WORD(Expected := 16#0001, Actual := fbDev.stSts.stCommon.wAlmActive, Message := 'condition still shown');
stCmd.stCommon.xSetManual := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'reannunciated after OutOfService');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmShelved, Message := 'no slots shelved');

coUnit.TEST_FINISHED();
