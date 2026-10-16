coUnit.TEST('MotorVfd_VfdNotReady_BlocksStart');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
fbVfd.xVfdReady := FALSE;
stCmd.xStart := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.stSts.stCommon.eCmdResult = E_CmdResult.RejectedPermit,
           Message := 'start rejected: VFD not ready');
AssertTrue(Condition := (fbVfd.stSts.stCommon.wStatus AND GVL_Const.MOT_STS_PERMIT_MISSING) <> 0,
           Message := 'PERMIT_MISSING');
stCmd.stCommon.xSetAuto := TRUE;
fbVfd.xAutoRun := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 5, tDt := T#100MS);
AssertFalse(Condition := fbVfd.xQRun, Message := 'Auto waits');
AssertFalse(Condition := fbVfd.ReadyToStart, Message := 'not ready to start');
fbVfd.xVfdReady := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.xQRun, Message := 'starts when VFD ready');

coUnit.TEST_FINISHED();
