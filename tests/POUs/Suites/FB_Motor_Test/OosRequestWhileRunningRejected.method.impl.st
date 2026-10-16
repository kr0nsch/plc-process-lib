coUnit.TEST('Motor_OosRequestWhileRunning_Rejected');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.stCommon.xSetOos := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.RejectedState,
           Message := 'OOS rejected while running');
AssertTrue(Condition := fbMot.Mode = E_DeviceMode.Manual, Message := 'still Manual');
AssertTrue(Condition := fbMot.xQRun, Message := 'still running');
stCmd.xStop := TRUE;
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.stCommon.xSetOos := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'OOS accepted when stopped');
AssertTrue(Condition := fbMot.Mode = E_DeviceMode.OutOfService, Message := 'OutOfService');
AssertTrue(Condition := fbMot.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction in OOS');
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.RejectedMode, Message := 'start rejected in OOS');
AssertFalse(Condition := fbMot.xQRun, Message := 'outputs off');

coUnit.TEST_FINISHED();
