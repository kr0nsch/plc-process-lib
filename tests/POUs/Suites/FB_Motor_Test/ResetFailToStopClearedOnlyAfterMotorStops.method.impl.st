coUnit.TEST('Motor_ResetFailToStop_ClearedOnlyAfterMotorStops');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.xStop := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 51, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_FAIL_TO_STOP, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'fail to stop');
stCmd.stCommon.xReset := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQReset, Message := 'reset pulse');
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_FAIL_TO_STOP, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'not cleared while still running');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 30, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.RejectedFault,
           Message := 'rejected at window end');
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_FAIL_TO_STOP, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'still latched');
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.stCommon.xReset := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'cleared after the stop');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopped, Message := 'stopped');

coUnit.TEST_FINISHED();
