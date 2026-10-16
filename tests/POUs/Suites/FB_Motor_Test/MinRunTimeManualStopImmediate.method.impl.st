coUnit.TEST('Motor_MinRunTime_ManualStopImmediate');

stCfg.tMinRun := T#10S;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#100MS);
stCmd.xStop := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQRun, Message := 'manual stop immediate');
Spin(fbM := fbMot2, fbT := fbTime2, stC := stCmd2, stR := stRetain2, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd2.stCommon.xSetAuto := TRUE;
fbMot2.xAutoRun := TRUE;
fbMot2.xFbRun := TRUE;
Spin(fbM := fbMot2, fbT := fbTime2, stC := stCmd2, stR := stRetain2, stF := stCfg, uiN := 1, tDt := T#100MS);
Spin(fbM := fbMot2, fbT := fbTime2, stC := stCmd2, stR := stRetain2, stF := stCfg, uiN := 10, tDt := T#100MS);
fbMot2.wInterlock := 16#0100;
Spin(fbM := fbMot2, fbT := fbTime2, stC := stCmd2, stR := stRetain2, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := fbMot2.xQRun, Message := 'interlock stop ignores tMinRun');

coUnit.TEST_FINISHED();
