coUnit.TEST('Pid_PvInvalidAlarm_ActiveOnlyInAuto');
stCfg.udiAlarmIdBase := 70;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := FALSE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual, PV негодна
itfAlm := fbPid.GetAlarm(uiIndex := TO_UINT(E_PidAlarm.PvInvalid));
eStMan := itfAlm.State;
fbPid.xPvValid := TRUE;
stCmd.stCommon.xSetAuto := TRUE;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto
fbPid.xPvValid := FALSE;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // отказ PV в Auto
eStAuto := itfAlm.State;
stCmd.stCommon.xAck := TRUE;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
eStAck := itfAlm.State;
fbPid.xPvValid := TRUE;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := eStMan = E_AlarmState.Normal, Message := 'no alarm in Manual');
AssertTrue(Condition := eStAuto = E_AlarmState.ActiveUnack, Message := 'ActiveUnack in Auto');
AssertEquals_UDINT(Expected := 70, Actual := itfAlm.Id, Message := 'alarm id = base + slot 0');
AssertTrue(Condition := eStAck = E_AlarmState.ActiveAck, Message := 'ActiveAck after xAck');
AssertTrue(Condition := itfAlm.State = E_AlarmState.Normal, Message := 'Normal after PV recovery');
coUnit.TEST_FINISHED();
