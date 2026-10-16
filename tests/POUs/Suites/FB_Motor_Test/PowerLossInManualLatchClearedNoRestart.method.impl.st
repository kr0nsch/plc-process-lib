coUnit.TEST('Motor_PowerLossInManual_LatchClearedNoRestart');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xPowerOk := FALSE;
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xPowerOk := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQRun, Message := 'no restart in Manual');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopped, Message := 'stopped');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no fault');

coUnit.TEST_FINISHED();
