coUnit.TEST('Motor_LocalMode_OutputsOffTracksFeedback');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xLocal := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.Mode = E_DeviceMode.Local, Message := 'Local');
AssertFalse(Condition := fbMot.xQRun, Message := 'outputs off in Local');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'state follows feedback');
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 60, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopped, Message := 'stopped by feedback');
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 60, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no feedback supervision in Local');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'running locally');
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.RejectedMode,
           Message := 'start rejected in Local');
fbMot.wInterlock := 16#0001;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := (fbMot.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_INTERLOCK_IN_LOCAL) <> 0,
           Message := 'interlock in Local is a warning');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'PLC cannot stop a local motor');

coUnit.TEST_FINISHED();
