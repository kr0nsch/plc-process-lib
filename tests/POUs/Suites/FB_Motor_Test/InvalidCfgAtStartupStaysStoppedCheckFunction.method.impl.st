coUnit.TEST('Motor_InvalidCfgAtStartup_StaysStoppedCheckFunction');

stCfg.uiMaxStartsPerHour := 31;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertEquals_WORD(Expected := GVL_Const.MOT_CFG_STARTS_LIMIT, Actual := fbMot.stSts.stCommon.wCfgErr,
                  Message := 'cfg error bit 1');
AssertTrue(Condition := fbMot.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction');
AssertTrue(Condition := (fbMot.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_CFG_ERROR) <> 0,
           Message := 'CFG_ERROR bit');
stCmd.stCommon.xSetAuto := TRUE;
fbMot.xAutoRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 100, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQRun, Message := 'no start without valid cfg');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopped, Message := 'stopped');
AssertFalse(Condition := fbMot.Available, Message := 'not available');
stCmd.stCommon.xSetManual := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.RejectedCfg,
           Message := 'start rejected: no valid cfg');
AssertFalse(Condition := fbMot.xQRun, Message := 'not started');

coUnit.TEST_FINISHED();
