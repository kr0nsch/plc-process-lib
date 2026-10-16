coUnit.TEST('MotorVfd_SpeedSpNaN_HoldsRef');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbVfd.xAutoRun := TRUE;
fbVfd.rSpeedSpAuto_pct := 60.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xVfdRunning := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
uBits.dwValue := 16#7FC00000;
fbVfd.rSpeedSpAuto_pct := uBits.rValue;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 60.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'reference held');
AssertTrue(Condition := (fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_SPEED_SP_INVALID) <> 0,
           Message := 'SP_INVALID');
AssertEquals_REAL(Expected := 60.0, Actual := stCmd.rSpeedSp_pct, Delta := 1.0E-4, Message := 'NaN not tracked');
fbVfd.rSpeedSpAuto_pct := 70.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 70.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'finite target');
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_SPEED_SP_INVALID,
                  Message := 'warning cleared');

coUnit.TEST_FINISHED();
