coUnit.TEST('MotorVfd_StartWithNaNTarget_RefStartsAtMin');

stCfg.stVfd.rSpeedMin_pct := 25.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbVfd.rSpeedSpAuto_pct := 60.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 0.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'stopped: zero');
uBits.dwValue := 16#7FC00000;
fbVfd.rSpeedSpAuto_pct := uBits.rValue;
fbVfd.xAutoRun := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Starting, Message := 'starting');
// AssertEquals_REAL пропускает NaN (ABS(NaN) > Delta = FALSE): конечность проверяется отдельно
AssertTrue(Condition := F_IsFinite(rIn := fbVfd.rSpeedRef_pct), Message := 'reference finite');
AssertEquals_REAL(Expected := 25.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'start at min speed');
AssertTrue(Condition := (fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_SPEED_SP_INVALID) <> 0,
           Message := 'SP_INVALID');
fbVfd.rSpeedSpAuto_pct := 70.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 70.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'finite target');

coUnit.TEST_FINISHED();
