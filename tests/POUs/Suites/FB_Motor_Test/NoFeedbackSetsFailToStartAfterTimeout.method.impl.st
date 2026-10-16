coUnit.TEST('Motor_NoFeedback_SetsFailToStartAfterTimeout');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 49, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no fault at t0 + 4.9 s');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Starting, Message := 'still starting at t0 + 4.9 s');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_FAIL_TO_START, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'FailToStart exactly at t0 + 5.0 s');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Fault, Message := 'state Fault');
AssertFalse(Condition := fbMot.xQRun, Message := 'outputs off');
AssertTrue(Condition := fbMot.Status = E_Ne107Status.Failure, Message := 'NE 107 Failure');
AssertTrue(Condition := fbMot.Fault, Message := 'Fault property');
itfAlm := fbMot.GetAlarm(uiIndex := E_MotorAlarm.FailToStart);
AssertTrue(Condition := itfAlm.Active, Message := 'slot 0 alarm active');
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'slot 0 alarm unacknowledged');

coUnit.TEST_FINISHED();
