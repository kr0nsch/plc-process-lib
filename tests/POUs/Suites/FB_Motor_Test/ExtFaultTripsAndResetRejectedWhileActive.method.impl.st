coUnit.TEST('Motor_ExtFault_TripsAndResetRejectedWhileActive');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xExtFault := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 2, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'filtered at t1 + 0.1 s');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_EXT_FAULT, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'trip at t1 + 0.2 s');
AssertFalse(Condition := fbMot.xQRun, Message := 'outputs off');
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
uiSeqExp := fbMot.stSts.stCommon.uiCmdSeq + 2;
stCmd.stCommon.xReset := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'reset accepted');
AssertTrue(Condition := fbMot.xQReset, Message := 'reset pulse');
AssertFalse(Condition := stCmd.stCommon.xReset, Message := 'reset bit cleared');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 29, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted,
           Message := 'window still open at 2.9 s');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.RejectedFault,
           Message := 'cause still active at window end');
AssertEquals_UINT(Expected := uiSeqExp, Actual := fbMot.stSts.stCommon.uiCmdSeq,
                  Message := 'two results for one reset');
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_EXT_FAULT, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'fault stays latched');

coUnit.TEST_FINISHED();
