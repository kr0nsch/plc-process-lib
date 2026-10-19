coUnit.TEST('Motor_TimeBackwardsDuringMinRun_KeepsRunning');

stCfg.tMinRun := T#10S;
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbMot.xAutoRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 20, tDt := T#100MS);
fbMot.xAutoRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQRun, Message := 'precondition: held by tMinRun');
fbTime.SetNow(ltValue := fbTime.Now() - LTIME#30S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.xQRun, Message := 'time went backwards: still running');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 99, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQRun, Message := 'running until tMinRun counted anew (9.9 s)');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQRun, Message := 'stopped 10 s after the jump');

coUnit.TEST_FINISHED();
