coUnit.TEST('Pid_InvalidCfg_StartupManualOutput');
stCfg.rKp := 0.0;
stCmd.rManualOut_pct := 150.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0
AssertEquals_REAL(Expected := 100.0, Actual := fbPid.rOut_pct, Delta := 0.0, Message := 'LIMIT(0, 150, 100)');
AssertTrue(Condition := fbPid.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction');
AssertEquals_WORD(Expected := GVL_Const.PID_CFG_KP, Actual := fbPid.stSts.stCommon.wCfgErr, Message := 'wCfgErr KP');
AssertEquals_WORD(Expected := GVL_Const.DEV_STS_CFG_ERROR,
                  Actual := fbPid.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_CFG_ERROR, Message := 'CFG_ERROR bit');
AssertFalse(Condition := fbPid.Available, Message := 'not available');
AssertEquals_REAL(Expected := 150.0, Actual := stCmd.rManualOut_pct, Delta := 0.0, Message := 'operator value kept');
stCmd.stCommon.xSetAuto := TRUE;
stCmd.rManualOut_pct := 37.5;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbPid.stSts.stCommon.eCmdResult = E_CmdResult.RejectedCfg, Message := 'Auto: RejectedCfg');
AssertTrue(Condition := fbPid.Mode = E_DeviceMode.Manual, Message := 'stays Manual');
AssertFalse(Condition := stCmd.stCommon.xSetAuto, Message := 'request cleared');
AssertEquals_REAL(Expected := 37.5, Actual := fbPid.rOut_pct, Delta := 0.0, Message := 'follows operator value');
AssertFalse(Condition := fbPid.xSatHigh OR fbPid.xSatLow, Message := 'no saturation flags without Cfg');
coUnit.TEST_FINISHED();
