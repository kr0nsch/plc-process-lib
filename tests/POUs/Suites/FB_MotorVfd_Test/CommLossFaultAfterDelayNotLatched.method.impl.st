coUnit.TEST('MotorVfd_CommLoss_FaultAfterDelayNotLatched');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbVfd.xAutoRun := TRUE;
fbVfd.rSpeedSpAuto_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xCommOk := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := (fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_FB_SUSPENDED) <> 0,
           Message := 'supervision suspended');
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'no fault yet');
AssertTrue(Condition := fbVfd.xQRun, Message := 'still commanded');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 29, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'no fault at 2.9 s');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_COMM_LOSS, Actual := fbVfd.stSts.stCommon.wFault,
                  Message := 'comm fault at 3.0 s');
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Fault, Message := 'state Fault');
AssertFalse(Condition := fbVfd.xQRun, Message := 'outputs off');
AssertFalse(Condition := fbVfd.Available, Message := 'not available');
itfAlm := fbVfd.GetAlarm(uiIndex := E_MotorAlarm.CommLoss);
AssertTrue(Condition := itfAlm.Active, Message := 'slot 6 alarm active');
AssertEquals_REAL(Expected := 50.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'reference held');
fbVfd.xCommOk := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'not latched');
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Running, Message := 'running again with Auto demand');
AssertTrue(Condition := fbVfd.xQRun, Message := 'run command on');

coUnit.TEST_FINISHED();
