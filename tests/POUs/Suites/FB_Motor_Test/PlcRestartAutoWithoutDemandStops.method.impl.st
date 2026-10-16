coUnit.TEST('Motor_PlcRestart_AutoWithoutDemand_Stops');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopping, Message := 'stopping');
AssertFalse(Condition := fbMot.xQRun, Message := 'no run command');
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopped, Message := 'stopped');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no fault');

coUnit.TEST_FINISHED();
