coUnit.TEST('Motor_FailToStop_RaisesHighPriorityAlarm');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.xStop := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopping, Message := 'stopping');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 49, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no fault at t0 + 4.9 s');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_FAIL_TO_STOP, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'FailToStop at t0 + 5.0 s');
itfAlm := fbMot.GetAlarm(uiIndex := E_MotorAlarm.FailToStop);
AssertTrue(Condition := itfAlm.Active, Message := 'slot 2 alarm active');
AssertTrue(Condition := itfAlm.AlarmPriority = E_AlarmPriority.High, Message := 'slot 2 priority High');
AssertTrue(Condition := fbMot.stSts.stCommon.ePrioUnack = E_AlarmPriority.High, Message := 'summary priority High');
AssertEquals_WORD(Expected := 16#0004, Actual := fbMot.stSts.stCommon.wAlmActive, Message := 'only slot 2 active');

coUnit.TEST_FINISHED();
