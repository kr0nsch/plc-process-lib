coUnit.TEST('Motor_Interlock_StopsInAutoAndManual_RecordsFirstOut');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbMot.xAutoRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.wInterlock := 16#0028;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQRun, Message := 'interlock stops in Auto');
AssertEquals_UINT(Expected := 3, Actual := fbMot.stSts.uiFirstOut, Message := 'lowest newly set bit');
AssertEquals_WORD(Expected := 16#0028, Actual := fbMot.stSts.wInterlock, Message := 'active interlocks');
AssertTrue(Condition := (fbMot.stSts.stCommon.wStatus AND GVL_Const.MOT_STS_INTERLOCKED) <> 0,
           Message := 'status INTERLOCKED');
AssertFalse(Condition := fbMot.Available, Message := 'not available while interlocked');
fbMot.wInterlock := 16#002A;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_UINT(Expected := 3, Actual := fbMot.stSts.uiFirstOut, Message := 'first out kept');
AssertTrue(Condition := fbMot.Mode = E_DeviceMode.Auto, Message := 'interlock does not change the mode');
fbMot.xFbRun := FALSE;
fbMot.xAutoRun := FALSE;
fbMot.wInterlock := 16#0000;
stCmd.stCommon.xSetManual := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'running in Manual');
AssertEquals_UINT(Expected := GVL_Const.NO_FIRST_OUT, Actual := fbMot.stSts.uiFirstOut,
                  Message := 'first out cleared on entry to Starting');
fbMot.wInterlock := 16#0010;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQRun, Message := 'interlock stops in Manual');
AssertEquals_UINT(Expected := 4, Actual := fbMot.stSts.uiFirstOut, Message := 'first out bit 4');
fbMot.wInterlock := 16#0000;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQRun, Message := 'manual latch removed by the interlock');

coUnit.TEST_FINISHED();
