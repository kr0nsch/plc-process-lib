coUnit.TEST('Pid_PvFail_ShedToManual_AlarmStaysActive');
stCfg.ePvFailAction := E_PidPvFailAction.ShedToManual;
stCfg.udiAlarmIdBase := 70;
stCmd.rManualOut_pct := 30.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
itfAlm := fbPid.GetAlarm(uiIndex := TO_UINT(E_PidAlarm.PvInvalid));
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto
fbPid.xPvValid := FALSE;                                                               // отказ PV
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // сброс в Manual
eModeSh := fbPid.Mode;
eStShed := itfAlm.State;
FOR iStep := 1 TO 50 DO                                                                // 5 с, PV негодна
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
eStHeld := itfAlm.State;
wActHeld := fbPid.stSts.stCommon.wAlmActive;
wUnaHeld := fbPid.stSts.stCommon.wAlmUnack;
fbPid.xPvValid := TRUE;                                                                // PV вернулась
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
eStRtn := itfAlm.State;
stCmd.stCommon.xAck := TRUE;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
eStAck := itfAlm.State;
// Manual после OutOfService выбрал оператор: негодная PV тревоги не даёт
stCmd.stCommon.xSetOos := TRUE;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbPid.xPvValid := FALSE;
stCmd.stCommon.xSetManual := TRUE;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
eStOper := itfAlm.State;
AssertTrue(Condition := eModeSh = E_DeviceMode.Manual, Message := 'shed to Manual');
AssertTrue(Condition := eStShed = E_AlarmState.ActiveUnack, Message := 'alarm ActiveUnack in the shed call');
AssertTrue(Condition := eStHeld = E_AlarmState.ActiveUnack, Message := 'alarm stays active while PV is invalid');
AssertEquals_WORD(Expected := 16#0001, Actual := wActHeld, Message := 'wAlmActive slot 0 while PV is invalid');
AssertEquals_WORD(Expected := 16#0001, Actual := wUnaHeld, Message := 'wAlmUnack slot 0 while PV is invalid');
AssertTrue(Condition := eStRtn = E_AlarmState.RtnUnack, Message := 'RtnUnack after PV recovery');
AssertTrue(Condition := eStAck = E_AlarmState.Normal, Message := 'Normal after xAck');
AssertTrue(Condition := eStOper = E_AlarmState.Normal, Message := 'no alarm in operator-selected Manual');
coUnit.TEST_FINISHED();
