coUnit.TEST('Motor_OosEntry_ClearsLatchedFaultsAndFirstOut');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 50, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_FAIL_TO_START, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'latched fault');
fbMot.wInterlock := 16#0004;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_UINT(Expected := 2, Actual := fbMot.stSts.uiFirstOut, Message := 'first out recorded');
stCmd.stCommon.xSetOos := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.Mode = E_DeviceMode.OutOfService, Message := 'OutOfService');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'latched fault cleared');
AssertEquals_UINT(Expected := GVL_Const.NO_FIRST_OUT, Actual := fbMot.stSts.uiFirstOut, Message := 'first out cleared');
AssertTrue(Condition := fbMot.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction');
itfAlm := fbMot.GetAlarm(uiIndex := E_MotorAlarm.FailToStart);
AssertTrue(Condition := itfAlm.State = E_AlarmState.OutOfService, Message := 'alarm OutOfService');

coUnit.TEST_FINISHED();
