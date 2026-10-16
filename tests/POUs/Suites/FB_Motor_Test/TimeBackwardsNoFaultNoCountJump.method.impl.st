coUnit.TEST('Motor_TimeBackwards_NoFaultNoCountJump');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#1S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 5, tDt := T#1S);
AssertEquals_UDINT(Expected := 5, Actual := stRetain.udiOpTime_s, Message := '5 s before');
fbTime.SetNow(ltValue := fbTime.Now() - LTIME#30S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no fault on time going backwards');
AssertEquals_UDINT(Expected := 5, Actual := stRetain.udiOpTime_s, Message := 'no jump');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 2, tDt := T#1S);
AssertEquals_UDINT(Expected := 7, Actual := stRetain.udiOpTime_s, Message := 'counting continues');
AssertTrue(Condition := fbMot.xQRun, Message := 'still running');

coUnit.TEST_FINISHED();
