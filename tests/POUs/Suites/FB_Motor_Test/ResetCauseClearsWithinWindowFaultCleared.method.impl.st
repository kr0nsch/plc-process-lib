coUnit.TEST('Motor_Reset_CauseClearsWithinWindow_FaultCleared');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xExtFault := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 3, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_EXT_FAULT, Actual := fbMot.stSts.stCommon.wFault, Message := 'tripped');
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.stCommon.xReset := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_EXT_FAULT, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'cause active at reset');
uiSeqExp := fbMot.stSts.stCommon.uiCmdSeq;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 9, tDt := T#100MS);
fbMot.xExtFault := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'cleared within the window');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopped, Message := 'stopped');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 30, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted,
           Message := 'no RejectedFault at window end');
AssertEquals_UINT(Expected := uiSeqExp, Actual := fbMot.stSts.stCommon.uiCmdSeq, Message := 'no extra result');

coUnit.TEST_FINISHED();
