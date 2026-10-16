coUnit.TEST('MotorVfd_CommLoss_SuppressesFeedbackSupervisionImmediately');

stCfg.tFbStart := T#2S;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.rSpeedSp_pct := 50.0;
stCmd.xStart := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 9, tDt := T#100MS);
fbVfd.xCommOk := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 24, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault,
                  Message := 'no FailToStart while feedback invalid');
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Starting, Message := 'state held');
AssertTrue(Condition := (fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_FB_SUSPENDED) <> 0,
           Message := 'FB_SUSPENDED');
fbVfd.xCommOk := TRUE;
fbVfd.xVfdRunning := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Running, Message := 'running');
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'no fault');

coUnit.TEST_FINISHED();
