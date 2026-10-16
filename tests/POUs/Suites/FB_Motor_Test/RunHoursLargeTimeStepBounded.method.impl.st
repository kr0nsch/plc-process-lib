coUnit.TEST('Motor_RunHours_LargeTimeStep_Bounded');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#1H);
AssertEquals_UDINT(Expected := 10, Actual := stRetain.udiOpTime_s, Message := 'step bounded by DT_ACCUM_MAX');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#3S);
AssertEquals_UDINT(Expected := 13, Actual := stRetain.udiOpTime_s, Message := 'normal step counted');

coUnit.TEST_FINISHED();
