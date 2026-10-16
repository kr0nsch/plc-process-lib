coUnit.TEST('Motor_PlcRestart_RunningFeedback_Adopted');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbMot.xAutoRun := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.Mode = E_DeviceMode.Auto, Message := 'Auto from retain');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'adopted in Auto');
AssertTrue(Condition := fbMot.xQRun, Message := 'run command on');
AssertEquals_UDINT(Expected := 0, Actual := stRetain.udiOpCount, Message := 'adoption is not a start');
AssertEquals_UINT(Expected := 0, Actual := fbMot.stSts.uiStartsLastHour, Message := 'not in starts window');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 60, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no uncommanded run');
fbMot2.xFbRun := TRUE;
Spin(fbM := fbMot2, fbT := fbTime2, stC := stCmd2, stR := stRetain2, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot2.stSts.eState = E_MotorState.Running, Message := 'adopted in Manual');
AssertTrue(Condition := fbMot2.xQRun, Message := 'manual latch set by adoption');
Spin(fbM := fbMot2, fbT := fbTime2, stC := stCmd2, stR := stRetain2, stF := stCfg, uiN := 60, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot2.stSts.stCommon.wFault, Message := 'no fault in Manual');

coUnit.TEST_FINISHED();
