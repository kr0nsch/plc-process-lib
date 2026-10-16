coUnit.TEST('Motor_Starts_CountedOnFeedbackEdge');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#100MS);
AssertEquals_UDINT(Expected := 0, Actual := stRetain.udiOpCount, Message := 'no feedback yet');
AssertEquals_UINT(Expected := 1, Actual := fbMot.stSts.uiStartsLastHour, Message := 'start attempt registered');
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_UDINT(Expected := 1, Actual := stRetain.udiOpCount, Message := 'counted on feedback edge');
AssertEquals_UDINT(Expected := 1, Actual := stRetain.udiOpCountMaint, Message := 'counted since maintenance');
stCmd.xStop := TRUE;
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xLocal := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_UDINT(Expected := 2, Actual := stRetain.udiOpCount, Message := 'local start counted');
AssertEquals_UDINT(Expected := 2, Actual := fbMot.Starts, Message := 'Starts property');
AssertEquals_UINT(Expected := 2, Actual := fbMot.stSts.uiStartsLastHour, Message := 'local start in window');

coUnit.TEST_FINISHED();
