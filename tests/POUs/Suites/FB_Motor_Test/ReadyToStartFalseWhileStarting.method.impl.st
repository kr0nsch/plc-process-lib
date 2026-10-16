coUnit.TEST('Motor_ReadyToStart_FalseWhileStarting');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.ReadyToStart, Message := 'stopped in Auto: ready');
fbMot.xAutoRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Starting, Message := 'starting');
AssertFalse(Condition := fbMot.ReadyToStart, Message := 'starting: not ready to start');
AssertTrue(Condition := fbMot.Available, Message := 'still available');
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'running');
AssertFalse(Condition := fbMot.ReadyToStart, Message := 'running: not ready to start');

coUnit.TEST_FINISHED();
