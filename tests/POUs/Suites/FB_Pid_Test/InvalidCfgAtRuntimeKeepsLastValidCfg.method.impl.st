coUnit.TEST('Pid_InvalidCfgAtRuntime_KeepsLastValidCfg');
// источник: tools/reference/pid.py, сценарий p_only (Kp = 2, без I, смещение 40 %)
stCfg.rKp := 2.0;
stCfg.rTi_s := 0.0;
stCmd.rManualOut_pct := 40.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto
stCfg.rKp := -1.0;                                                                     // Cfg испорчена
fbPid.rPv_eu := 45.0;                                                                  // e = +5 %
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// ref: p_only.out_e5
AssertEquals_REAL(Expected := 50.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'control with LKG Kp = 2');
AssertEquals_WORD(Expected := GVL_Const.PID_CFG_KP, Actual := fbPid.stSts.stCommon.wCfgErr, Message := 'wCfgErr KP');
AssertTrue(Condition := fbPid.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction');
AssertTrue(Condition := fbPid.Mode = E_DeviceMode.Auto, Message := 'keeps Auto');
AssertTrue(Condition := fbPid.Available, Message := 'still available');
coUnit.TEST_FINISHED();
