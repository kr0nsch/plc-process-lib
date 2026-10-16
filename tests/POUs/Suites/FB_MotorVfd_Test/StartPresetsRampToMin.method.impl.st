coUnit.TEST('MotorVfd_StartPresetsRampToMin');

stCfg.stVfd.rSpeedMin_pct := 30.0;
stCfg.stVfd.rRampUp_pctps := 10.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertEquals_REAL(Expected := 0.0, Actual := fbVfd.rSpeedRef_pct, Delta := 0.0, Message := 'zero while stopped');
stCmd.rSpeedSp_pct := 80.0;
stCmd.xStart := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 30.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'preset to min');
fbVfd.xVfdRunning := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 31.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'first ramp step');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 9, tDt := T#100MS);
AssertEquals_REAL(Expected := 40.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'after 1 s');

coUnit.TEST_FINISHED();
