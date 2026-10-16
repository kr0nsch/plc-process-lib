coUnit.TEST('MotorVfd_VfdFault_TripsAndResetPulses');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.rSpeedSp_pct := 50.0;
stCmd.xStart := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xVfdFault := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 3, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_EXT_FAULT, Actual := fbVfd.stSts.stCommon.wFault,
                  Message := 'VFD fault latched');
AssertFalse(Condition := fbVfd.xQRun, Message := 'outputs off');
fbVfd.xVfdRunning := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.stCommon.xReset := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.xQReset, Message := 'reset pulse to VFD');
AssertTrue(Condition := fbVfd.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'reset accepted');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 4, tDt := T#100MS);
fbVfd.xVfdFault := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'cleared within the reset window');
AssertTrue(Condition := fbVfd.xQReset, Message := 'pulse still on at 0.5 s');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 30, tDt := T#100MS);
AssertTrue(Condition := fbVfd.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'no RejectedFault');

coUnit.TEST_FINISHED();
