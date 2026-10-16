coUnit.TEST('MotorVfd_LocalMode_RefTracksActualSpeed');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.rSpeedSp_pct := 50.0;
stCmd.xStart := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xLocal := TRUE;
fbVfd.rSpeedAct_pct := 42.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := fbVfd.xQRun, Message := 'outputs off in Local');
AssertEquals_REAL(Expected := 42.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'ref tracks actual');
AssertEquals_REAL(Expected := 42.0, Actual := stCmd.rSpeedSp_pct, Delta := 1.0E-4, Message := 'setpoint tracks');
fbVfd.xLocal := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.xQRun, Message := 'keeps running in Manual');
AssertEquals_REAL(Expected := 42.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'bumpless');

coUnit.TEST_FINISHED();
