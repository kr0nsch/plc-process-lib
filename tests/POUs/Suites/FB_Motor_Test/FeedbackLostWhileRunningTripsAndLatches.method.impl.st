coUnit.TEST('Motor_FeedbackLostWhileRunning_TripsAndLatches');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'running');
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 5, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no trip before the filter time');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_FEEDBACK_LOST, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'FeedbackLost after tFbLossFilter');
AssertFalse(Condition := fbMot.xQRun, Message := 'outputs off');
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 5, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_FEEDBACK_LOST, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'latched until Reset');
AssertFalse(Condition := fbMot.xQRun, Message := 'manual latch cleared by the fault');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Fault, Message := 'state Fault');

coUnit.TEST_FINISHED();
