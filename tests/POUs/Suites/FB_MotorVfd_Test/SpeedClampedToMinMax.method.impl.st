coUnit.TEST('MotorVfd_SpeedClampedToMinMax');

stCfg.stVfd.rSpeedMin_pct := 20.0;
stCfg.stVfd.rSpeedMax_pct := 90.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbVfd.xAutoRun := TRUE;
fbVfd.rSpeedSpAuto_pct := 95.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xVfdRunning := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 90.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'clamped to max');
AssertEquals_REAL(Expected := 90.0, Actual := stCmd.rSpeedSp_pct, Delta := 1.0E-4, Message := 'tracking clamped');
fbVfd.rSpeedSpAuto_pct := 5.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 20.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'clamped to min');
stCmd.stCommon.xSetManual := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.rSpeedSp_pct := 150.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 90.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'manual clamped');
AssertEquals_REAL(Expected := 90.0, Actual := stCmd.rSpeedSp_pct, Delta := 1.0E-4, Message := 'written back');

coUnit.TEST_FINISHED();
