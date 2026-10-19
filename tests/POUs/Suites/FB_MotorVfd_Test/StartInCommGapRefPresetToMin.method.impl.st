coUnit.TEST('MotorVfd_StartInCommGap_RefPresetToMin');

stCfg.stVfd.rSpeedMin_pct := 30.0;
stCfg.stVfd.rRampUp_pctps := 1.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.rSpeedSp_pct := 80.0;
stCmd.xStart := TRUE;
fbVfd.xCommOk := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.xQRun, Message := 'start not blocked by a short gap');
fbVfd.xCommOk := TRUE;
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 0.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 30.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4,
                  Message := 'preset to min when comm returns');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 30.1, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'ramp from min');

coUnit.TEST_FINISHED();
