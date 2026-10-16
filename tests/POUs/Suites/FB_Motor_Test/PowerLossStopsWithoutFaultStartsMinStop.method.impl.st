coUnit.TEST('Motor_PowerLoss_StopsWithoutFault_StartsMinStop');

stCfg.tMinStop := T#20S;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbMot.xAutoRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 200, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQRun, Message := 'started after the pause from PLC start');
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.xPowerOk := FALSE;
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopped, Message := 'stopped');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault, Message := 'no fault on power loss');
AssertFalse(Condition := fbMot.xQRun, Message := 'run command removed');
AssertTrue(Condition := (fbMot.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_POWER_LOST) <> 0,
           Message := 'POWER_LOST warning');
AssertTrue(Condition := (fbMot.stSts.stCommon.wStatus AND GVL_Const.MOT_STS_START_INHIBIT) <> 0,
           Message := 'start inhibited');
AssertFalse(Condition := fbMot.Available, Message := 'not available without power');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 49, tDt := T#100MS);
fbMot.xPowerOk := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQRun, Message := 'pause counted from the power loss');
AssertEquals_UINT(Expected := 15, Actual := fbMot.stSts.uiInhibitRemain_s, Message := '15 s left');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 149, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQRun, Message := 'no start at 19.9 s');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQRun, Message := 'Auto restarts 20 s after power loss');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Starting, Message := 'starting');

coUnit.TEST_FINISHED();
