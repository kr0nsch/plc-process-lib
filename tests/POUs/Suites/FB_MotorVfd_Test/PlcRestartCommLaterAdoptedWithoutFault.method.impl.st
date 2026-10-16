coUnit.TEST('MotorVfd_PlcRestartCommLater_AdoptedWithoutFault');

fbVfd.xCommOk := FALSE;
fbVfd.xVfdRunning := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 5, tDt := T#100MS);
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Stopped, Message := 'no valid feedback yet');
AssertFalse(Condition := fbVfd.xQRun, Message := 'no command before adoption');
fbVfd.xCommOk := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Running, Message := 'adopted when comm appears');
AssertTrue(Condition := fbVfd.xQRun, Message := 'run command held');
AssertEquals_UDINT(Expected := 0, Actual := stRetain.udiOpCount, Message := 'adoption is not a start');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 60, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'no uncommanded run');

coUnit.TEST_FINISHED();
