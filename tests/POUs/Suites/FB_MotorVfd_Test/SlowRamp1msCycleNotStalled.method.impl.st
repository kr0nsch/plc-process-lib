coUnit.TEST('MotorVfd_SlowRamp1msCycle_NotStalled');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.rSpeedSp_pct := 70.0;
stCmd.xStart := TRUE;
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 70.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 2, tDt := T#100MS);
AssertEquals_REAL(Expected := 70.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'precondition: 70 pct');
stCfg.stVfd.rRampUp_pctps := 0.003;
stCfg.stVfd.rRampDown_pctps := 0.003;
stCmd.rSpeedSp_pct := 100.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1000, tDt := T#1MS);
AssertEquals_REAL(Expected := 70.003, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4,
                  Message := '1 ms cycle: ramp moves');

coUnit.TEST_FINISHED();
