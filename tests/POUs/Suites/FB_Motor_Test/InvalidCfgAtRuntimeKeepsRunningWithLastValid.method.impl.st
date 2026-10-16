coUnit.TEST('Motor_InvalidCfgAtRuntime_KeepsRunningWithLastValid');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCfg.tResetWindow := T#0S;
stCfg.tFbLossFilter := T#5S;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQRun, Message := 'keeps running');
AssertTrue(Condition := fbMot.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction');
AssertEquals_WORD(Expected := GVL_Const.MOT_CFG_RESET, Actual := fbMot.stSts.stCommon.wCfgErr,
                  Message := 'cfg error bit 2');
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 5, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no trip at 0.4 s');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_FEEDBACK_LOST, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'last valid filter time 500 ms used');

coUnit.TEST_FINISHED();
