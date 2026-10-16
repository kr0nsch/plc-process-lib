coUnit.TEST('Pid_DFilter_PvStep_DecaysWithTdOverN');
// источник: tools/reference/pid.py, сценарий d_filter
stCfg.rKp := 1.0;
stCfg.rTi_s := 0.0;
stCfg.rTd_s := 5.0;
stCfg.rDFilterN := 10.0;
stCmd.rManualOut_pct := 50.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto
fbPid.rPv_eu := 52.0;                                                                  // ступень PV
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rD1 := fbPid.stSts.rD_pct;
FOR iStep := 1 TO 5 DO                                                                 // ещё Tf = 0,5 с
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: d_filter.d_step
AssertEquals_REAL(Expected := -16.666666, Actual := rD1, Delta := 1.0E-4, Message := 'D right after PV step');
// ref: d_filter.d_after_tf
AssertEquals_REAL(Expected := -6.697959, Actual := fbPid.stSts.rD_pct, Delta := 1.0E-4, Message := 'D after Tf');
// ref: d_filter.ratio
AssertEquals_REAL(Expected := 0.401878, Actual := fbPid.stSts.rD_pct / rD1, Delta := 1.0E-5,
                  Message := 'decay (Tf / (Tf + dt))^5 over Tf = Td / N');
coUnit.TEST_FINISHED();
