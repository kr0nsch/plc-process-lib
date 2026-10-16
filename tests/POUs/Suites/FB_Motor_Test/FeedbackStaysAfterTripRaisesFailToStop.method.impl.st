coUnit.TEST('Motor_FeedbackStaysAfterTrip_RaisesFailToStop');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xExtFault := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 3, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_EXT_FAULT, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'ext fault trip');
AssertFalse(Condition := fbMot.xQRun, Message := 'outputs off');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 49, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_EXT_FAULT, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'only ext fault 4.9 s after the trip');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 2, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_EXT_FAULT OR GVL_Const.MOT_FLT_FAIL_TO_STOP,
                  Actual := fbMot.stSts.stCommon.wFault, Message := 'fail to stop after tFbStop');
itfAlm := fbMot.GetAlarm(uiIndex := E_MotorAlarm.FailToStop);
AssertTrue(Condition := itfAlm.Active, Message := 'slot 2 alarm active');
AssertTrue(Condition := fbMot.stSts.stCommon.ePrioUnack = E_AlarmPriority.High, Message := 'summary priority High');

coUnit.TEST_FINISHED();
