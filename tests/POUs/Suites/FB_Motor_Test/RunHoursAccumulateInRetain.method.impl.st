coUnit.TEST('Motor_RunHours_AccumulateInRetain');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#10S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 540, tDt := T#10S);
AssertEquals_UDINT(Expected := 5400, Actual := stRetain.udiOpTime_s, Message := 'run seconds in retain');
AssertEquals_REAL(Expected := 1.5, Actual := fbMot.stSts.rRunTime_h, Delta := 1.0E-5, Message := 'run hours');
AssertEquals_UDINT(Expected := 5400, Actual := stRetain.udiOpTimeMaint_s, Message := 'since maintenance');
AssertEquals_REAL(Expected := 1.5, Actual := fbMot.stSts.rRunTimeMaint_h, Delta := 1.0E-5,
                  Message := 'run hours since maintenance');
AssertEquals_UDINT(Expected := 5400, Actual := fbMot.RunSeconds, Message := 'RunSeconds property');
Spin(fbM := fbMot2, fbT := fbTime2, stC := stCmd2, stR := stRetain2, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd2.xStart := TRUE;
fbMot2.xFbRun := TRUE;
Spin(fbM := fbMot2, fbT := fbTime2, stC := stCmd2, stR := stRetain2, stF := stCfg, uiN := 1, tDt := T#100MS);
Spin(fbM := fbMot2, fbT := fbTime2, stC := stCmd2, stR := stRetain2, stF := stCfg, uiN := 25, tDt := T#100MS);
AssertEquals_UDINT(Expected := 2, Actual := stRetain2.udiOpTime_s, Message := 'whole seconds only');
Spin(fbM := fbMot2, fbT := fbTime2, stC := stCmd2, stR := stRetain2, stF := stCfg, uiN := 5, tDt := T#100MS);
AssertEquals_UDINT(Expected := 3, Actual := stRetain2.udiOpTime_s, Message := 'fraction kept in accumulator');

coUnit.TEST_FINISHED();
