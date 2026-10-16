coUnit.TEST('MotorVfd_CommRestored_RunningWithoutDemand_Stops');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.rSpeedSp_pct := 50.0;
stCmd.xStart := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xCommOk := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 31, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_COMM_LOSS, Actual := fbVfd.stSts.stCommon.wFault,
                  Message := 'comm fault');
fbVfd.xCommOk := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'fault gone');
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Stopping, Message := 'stopping: no demand');
AssertFalse(Condition := fbVfd.xQRun, Message := 'no run command');
fbVfd.xVfdRunning := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Stopped, Message := 'stopped');

coUnit.TEST_FINISHED();
