coUnit.TEST('MotorVfd_StopSetsRefZero');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.rSpeedSp_pct := 50.0;
stCmd.xStart := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 50.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'running at 50 %');
stCmd.xStop := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 0.0, Actual := fbVfd.rSpeedRef_pct, Delta := 0.0, Message := 'reference zero');
AssertFalse(Condition := fbVfd.xQRun, Message := 'run command off');

coUnit.TEST_FINISHED();
