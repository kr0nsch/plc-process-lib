coUnit.TEST('DigitalInput_OutOfService_AlarmsOutOfService');

SetAlarmPriority(stCfgDi := stCfg, uiSlot := E_DiAlarm.State, ePriority := E_AlarmPriority.Medium);
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
itfAlm := fbDi.GetAlarm(uiIndex := E_DiAlarm.State);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'state alarm active');
stCmd.stCommon.xSetOos := TRUE;
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbDi.Mode = E_DeviceMode.OutOfService, Message := 'out of service');
AssertTrue(Condition := itfAlm.State = E_AlarmState.OutOfService, Message := 'state slot out of service');
itfAlm := fbDi.GetAlarm(uiIndex := E_DiAlarm.Failure);
AssertTrue(Condition := itfAlm.State = E_AlarmState.OutOfService, Message := 'failure slot out of service');
AssertEquals_WORD(Expected := 16#0003, Actual := fbDi.stSts.stCommon.wAlmShelved, Message := 'both slots shelved bits');
AssertTrue(Condition := fbDi.xValue, Message := 'value held');
AssertFalse(Condition := fbDi.xValid, Message := 'invalid in OOS');
AssertTrue(Condition := fbDi.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, xChannelFault := TRUE, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbDi.Status = E_Ne107Status.CheckFunction, Message := 'no failure in OOS');
AssertEquals_WORD(Expected := 0, Actual := fbDi.stSts.stCommon.wFault, Message := 'no fault bit in OOS');
stCmd.stCommon.xSetAuto := TRUE;
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, xChannelFault := FALSE, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbDi.Mode = E_DeviceMode.Auto, Message := 'back in service');
itfAlm := fbDi.GetAlarm(uiIndex := E_DiAlarm.State);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'state alarm reannunciated');

coUnit.TEST_FINISHED();
