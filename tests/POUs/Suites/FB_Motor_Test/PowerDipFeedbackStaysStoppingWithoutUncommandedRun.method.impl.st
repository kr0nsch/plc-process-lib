coUnit.TEST('Motor_PowerDipFeedbackStays_StoppingWithoutUncommandedRun');

stCfg.tFbStop := T#10S;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'running');
fbMot.xPowerOk := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 3, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQRun, Message := 'command removed on power loss');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no fault during the dip');
fbMot.xPowerOk := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopping, Message := 'supervised stop after the dip');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 59, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'no uncommanded run while decelerating 6 s');
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopped, Message := 'stopped');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no fault');
AssertFalse(Condition := fbMot.xQRun, Message := 'no restart in Manual');

coUnit.TEST_FINISHED();
