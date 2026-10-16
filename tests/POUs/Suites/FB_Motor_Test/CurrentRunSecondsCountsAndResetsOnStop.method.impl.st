coUnit.TEST('Motor_CurrentRunSeconds_CountsAndResetsOnStop');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#1S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 65, tDt := T#1S);
AssertEquals_UDINT(Expected := 65, Actual := fbMot.CurrentRunSeconds, Message := 'current run 65 s');
AssertEquals_UDINT(Expected := 65, Actual := fbMot.stSts.udiRunCurrent_s, Message := 'in status');
stCmd.xStop := TRUE;
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertEquals_UDINT(Expected := 0, Actual := fbMot.CurrentRunSeconds, Message := 'zero when stopped');
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 3, tDt := T#1S);
AssertEquals_UDINT(Expected := 3, Actual := fbMot.CurrentRunSeconds, Message := 'new run counts from zero');
AssertEquals_UDINT(Expected := 68, Actual := fbMot.RunSeconds, Message := 'total run time continues');

coUnit.TEST_FINISHED();
