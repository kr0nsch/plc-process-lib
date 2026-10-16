coUnit.TEST('MotorVfd_ManualSpeed_TracksAutoForBumpless');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbVfd.xAutoRun := TRUE;
fbVfd.rSpeedSpAuto_pct := 60.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xVfdRunning := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 60.0, Actual := stCmd.rSpeedSp_pct, Delta := 1.0E-4, Message := 'tracking in Auto');
stCmd.stCommon.xSetManual := TRUE;
fbVfd.rSpeedSpAuto_pct := 30.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 60.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'no jump');
AssertEquals_REAL(Expected := 60.0, Actual := stCmd.rSpeedSp_pct, Delta := 1.0E-4, Message := 'setpoint kept');
AssertTrue(Condition := fbVfd.xQRun, Message := 'still running');

coUnit.TEST_FINISHED();
