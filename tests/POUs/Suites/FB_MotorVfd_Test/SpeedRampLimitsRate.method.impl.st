coUnit.TEST('MotorVfd_SpeedRamp_LimitsRate');

stCfg.stVfd.rSpeedMin_pct := 20.0;
stCfg.stVfd.rRampUp_pctps := 10.0;
stCfg.stVfd.rRampDown_pctps := 5.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbVfd.xAutoRun := TRUE;
fbVfd.rSpeedSpAuto_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 20.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'ramp starts at min');
fbVfd.xVfdRunning := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 15, tDt := T#100MS);
AssertEquals_REAL(Expected := 35.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'up 10 %/s, 1.5 s');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 15, tDt := T#100MS);
AssertEquals_REAL(Expected := 50.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'target reached');
fbVfd.rSpeedSpAuto_pct := 30.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 20, tDt := T#100MS);
AssertEquals_REAL(Expected := 40.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'down 5 %/s, 2 s');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 20, tDt := T#100MS);
AssertEquals_REAL(Expected := 30.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'new target');
AssertEquals_REAL(Expected := 30.0, Actual := fbVfd.stSts.rSpeedRef_pct, Delta := 1.0E-4, Message := 'in status');

coUnit.TEST_FINISHED();
