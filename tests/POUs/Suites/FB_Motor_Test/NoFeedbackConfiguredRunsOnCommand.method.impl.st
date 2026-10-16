coUnit.TEST('Motor_NoFeedbackConfigured_RunsOnCommand');

stCfg.xFbUsed := FALSE;
stCfg.tFbStart := T#0S;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wCfgErr,
                  Message := 'feedback times not checked without feedback');
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'running on command');
AssertTrue(Condition := fbMot.Running, Message := 'Running by command');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 100, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no FailToStart without feedback');
AssertEquals_UDINT(Expected := 10, Actual := stRetain.udiOpTime_s, Message := 'run time by command');
AssertEquals_UDINT(Expected := 1, Actual := stRetain.udiOpCount, Message := 'start by command');
stCmd.xStop := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopped, Message := 'stopped at once');
AssertFalse(Condition := fbMot.Running, Message := 'not running');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 100, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no FailToStop without feedback');

coUnit.TEST_FINISHED();
