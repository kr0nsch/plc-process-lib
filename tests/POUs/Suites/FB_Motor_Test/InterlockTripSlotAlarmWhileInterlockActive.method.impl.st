coUnit.TEST('Motor_InterlockTrip_SlotAlarmWhileInterlockActive');

stCfg.udiAlarmIdBase := 120;
SetSlotPriority(stCfgMot := stCfg, uiSlot := 5, ePrioSlot := E_AlarmPriority.Low);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.wInterlock := 16#0001;
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
itfAlm := fbMot.GetAlarm(uiIndex := E_MotorAlarm.InterlockTrip);
AssertTrue(Condition := itfAlm.Active, Message := 'interlock trip alarm active');
AssertEquals_UDINT(Expected := 125, Actual := itfAlm.Id, Message := 'alarm id base + 5');
fbMot.wInterlock := 16#0000;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := itfAlm.Active, Message := 'inactive after interlock clears');

coUnit.TEST_FINISHED();
