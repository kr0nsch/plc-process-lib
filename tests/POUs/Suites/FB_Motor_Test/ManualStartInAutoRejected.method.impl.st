coUnit.TEST('Motor_ManualStartInAuto_Rejected');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.RejectedMode,
           Message := 'start in Auto rejected');
AssertFalse(Condition := stCmd.xStart, Message := 'start pulse cleared');
AssertFalse(Condition := fbMot.xQRun, Message := 'not started');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopped, Message := 'stopped');
AssertTrue(Condition := fbMot.Mode = E_DeviceMode.Auto, Message := 'still Auto');

coUnit.TEST_FINISHED();
