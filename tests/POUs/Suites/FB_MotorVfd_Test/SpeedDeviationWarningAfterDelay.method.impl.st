coUnit.TEST('MotorVfd_SpeedDeviation_WarningAfterDelay');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbVfd.xAutoRun := TRUE;
fbVfd.rSpeedSpAuto_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 5, tDt := T#100MS);
fbVfd.rSpeedAct_pct := 35.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 99, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_SPEED_DEV,
                  Message := 'no warning at 9.9 s');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := (fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_SPEED_DEV) <> 0,
           Message := 'SPEED_DEV at 10 s');
AssertTrue(Condition := fbVfd.Status = E_Ne107Status.OutOfSpecification, Message := 'NE 107 S');
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'not a fault');
AssertTrue(Condition := fbVfd.xQRun, Message := 'keeps running');
itfAlm := fbVfd.GetAlarm(uiIndex := E_MotorAlarm.SpeedDeviation);
AssertTrue(Condition := itfAlm.Active, Message := 'slot 7 alarm active');

coUnit.TEST_FINISHED();
