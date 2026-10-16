coUnit.TEST('Motor_UncommandedRun_Detected');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.xRunning, Message := 'running by feedback');
AssertFalse(Condition := fbMot.xQRun, Message := 'no command');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 49, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no fault at t1 + 4.9 s');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_UNCOMMANDED_RUN, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'UncommandedRun at t1 + 5.0 s');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Fault, Message := 'state Fault');
AssertTrue(Condition := fbMot.stSts.stCommon.ePrioUnack = E_AlarmPriority.High, Message := 'High priority alarm');
AssertEquals_UDINT(Expected := 1, Actual := stRetain.udiOpCount, Message := 'feedback edge counted as start');
AssertEquals_UINT(Expected := 1, Actual := fbMot.stSts.uiStartsLastHour, Message := 'registered in starts window');

coUnit.TEST_FINISHED();
