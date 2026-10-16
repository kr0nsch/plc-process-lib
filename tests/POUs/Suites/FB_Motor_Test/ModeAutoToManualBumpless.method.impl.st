coUnit.TEST('Motor_ModeAutoToManual_Bumpless');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbMot.xAutoRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.stCommon.xSetManual := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.Mode = E_DeviceMode.Manual, Message := 'Manual');
AssertTrue(Condition := fbMot.xQRun, Message := 'keeps running after Auto -> Manual');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'running');
fbMot.xAutoRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQRun, Message := 'automation request not used in Manual');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'still running');

coUnit.TEST_FINISHED();
