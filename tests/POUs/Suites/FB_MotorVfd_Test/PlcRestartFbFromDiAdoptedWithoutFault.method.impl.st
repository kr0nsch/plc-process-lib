coUnit.TEST('MotorVfd_PlcRestartFbFromDi_AdoptedWithoutFault');

stCfg.stVfd.xFbFromComm := FALSE;
fbVfd.xFbRun := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Running, Message := 'adopted by DI feedback');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 60, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'no uncommanded run');
AssertTrue(Condition := fbVfd.xQRun, Message := 'run command held');

coUnit.TEST_FINISHED();
