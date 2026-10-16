coUnit.TEST('MotorVfd_SpeedDeviationDuringRamp_Ignored');

stCfg.stVfd.rRampUp_pctps := 1.0;
stCfg.stVfd.tSpeedDev := T#2S;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbVfd.xAutoRun := TRUE;
fbVfd.rSpeedSpAuto_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xVfdRunning := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 200, tDt := T#100MS);
AssertEquals_REAL(Expected := 20.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-3, Message := 'ramping at 20 s');
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_SPEED_DEV,
                  Message := 'no deviation warning while ramping');
fbVfd.rSpeedSpAuto_pct := 20.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 20, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_SPEED_DEV,
                  Message := 'tSpeedDev not yet elapsed');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := (fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_SPEED_DEV) <> 0,
           Message := 'warning after ramp done');

coUnit.TEST_FINISHED();
