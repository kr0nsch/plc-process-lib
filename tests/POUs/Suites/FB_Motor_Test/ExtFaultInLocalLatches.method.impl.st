coUnit.TEST('Motor_ExtFaultInLocal_Latches');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
fbMot.xLocal := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xExtFault := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 3, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_EXT_FAULT, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'latched in Local');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Fault, Message := 'Fault in Local');
fbMot.xExtFault := FALSE;
fbMot.xLocal := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_EXT_FAULT, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'still latched');
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.RejectedFault, Message := 'start rejected');

coUnit.TEST_FINISHED();
