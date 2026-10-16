coUnit.TEST('Motor_AutoRun_StartsAndConfirms');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbMot.xAutoRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.Mode = E_DeviceMode.Auto, Message := 'Auto');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Starting, Message := 'starting');
AssertTrue(Condition := fbMot.xQRun, Message := 'run command on');
AssertEquals_UINT(Expected := 1, Actual := fbMot.stSts.uiStartsLastHour, Message := 'start registered in window');
AssertEquals_UDINT(Expected := 0, Actual := stRetain.udiOpCount, Message := 'not counted before feedback');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#100MS);
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'running after feedback');
AssertTrue(Condition := fbMot.Running, Message := 'Running property');
AssertTrue(Condition := fbMot.xQRun, Message := 'run command held');
AssertEquals_UDINT(Expected := 1, Actual := stRetain.udiOpCount, Message := 'start counted on feedback edge');
AssertEquals_UDINT(Expected := 1, Actual := fbMot.Starts, Message := 'Starts property');
AssertTrue(Condition := fbMot.Available, Message := 'available in Auto');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no fault');
AssertTrue(Condition := (fbMot.stSts.stCommon.wStatus AND GVL_Const.MOT_STS_RUNNING) <> 0,
           Message := 'status bit RUNNING');
AssertTrue(Condition := (fbMot.stSts.stCommon.wStatus AND GVL_Const.MOT_STS_AVAILABLE) <> 0,
           Message := 'status bit AVAILABLE');

coUnit.TEST_FINISHED();
