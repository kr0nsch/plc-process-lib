coUnit.TEST('Motor_ManualStart_FeedbackOk_GoesRunning');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'start accepted');
AssertFalse(Condition := stCmd.xStart, Message := 'start pulse cleared');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Starting, Message := 'starting');
AssertTrue(Condition := fbMot.xQRun, Message := 'run command on');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 20, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Starting, Message := 'still waiting for feedback at 2 s');
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'running');
AssertTrue(Condition := fbMot.xRunning, Message := 'xRunning');
AssertTrue(Condition := (fbMot.stSts.stCommon.wStatus AND GVL_Const.MOT_STS_RUN_CMD) <> 0,
           Message := 'status bit RUN_CMD');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no fault');

coUnit.TEST_FINISHED();
