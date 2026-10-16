coUnit.TEST('Motor_StopInAuto_SwitchesToManualAndStops');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbMot.xAutoRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'running in Auto');
stCmd.xStop := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.Mode = E_DeviceMode.Manual, Message := 'stop in Auto switches to Manual');
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Manual, Message := 'Manual stored in retain');
AssertFalse(Condition := fbMot.xQRun, Message := 'run command removed');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopping, Message := 'stopping while feedback present');
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'stop accepted');
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopped, Message := 'stopped after feedback drops');
AssertFalse(Condition := fbMot.xRunning, Message := 'not running');

coUnit.TEST_FINISHED();
