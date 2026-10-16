coUnit.TEST('Motor_FeedbackDropoutWithinFilter_NotCountedAsStart');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#1S);
AssertEquals_UDINT(Expected := 1, Actual := stRetain.udiOpCount, Message := 'one start');
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 2, tDt := T#100MS);
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_UDINT(Expected := 1, Actual := stRetain.udiOpCount, Message := 'bounce is not a start');
AssertEquals_UDINT(Expected := 1, Actual := stRetain.udiOpCountMaint, Message := 'not a start since maintenance');
AssertEquals_UDINT(Expected := 10, Actual := fbMot.CurrentRunSeconds, Message := 'continuous run not reset');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#1S);
AssertEquals_UDINT(Expected := 20, Actual := fbMot.CurrentRunSeconds, Message := 'continuous run 20 s');
AssertEquals_UDINT(Expected := 20, Actual := fbMot.RunSeconds, Message := 'run time 20 s');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no fault');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'running');

coUnit.TEST_FINISHED();
