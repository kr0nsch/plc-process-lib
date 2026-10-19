coUnit.TEST('MotorVfd_SpeedActNaN_StsFinite');

itfLead := fbVfd;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.rSpeedSp_pct := 50.0;
stCmd.xStart := TRUE;
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 2, tDt := T#100MS);
uBits.dwValue := 16#7FC00000;
fbVfd.rSpeedAct_pct := uBits.rValue;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
// AssertEquals_REAL пропускает NaN (ABS(NaN) > Delta = FALSE): конечность проверяется отдельно
AssertTrue(Condition := F_IsFinite(rIn := fbVfd.stSts.rSpeedAct_pct) AND F_IsFinite(rIn := itfLead.SpeedAct)
                        AND F_IsFinite(rIn := fbVfd.rSpeedRef_pct),
           Message := 'Sts, SpeedAct and reference finite');
AssertEquals_REAL(Expected := 0.0, Actual := fbVfd.stSts.rSpeedAct_pct, Delta := 0.0,
                  Message := 'unknown speed shown as 0');
AssertEquals_REAL(Expected := 50.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'reference held');

coUnit.TEST_FINISHED();
