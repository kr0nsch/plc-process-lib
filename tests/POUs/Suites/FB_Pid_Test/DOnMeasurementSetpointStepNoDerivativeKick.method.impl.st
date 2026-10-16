coUnit.TEST('Pid_DOnMeasurement_SetpointStep_NoDerivativeKick');
// источник: tools/reference/pid.py, сценарий d_kick
stCfg.rKp := 1.0;
stCfg.rTi_s := 0.0;
stCfg.rTd_s := 5.0;
stCmd.rManualOut_pct := 50.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto
stCmd.rSp_eu := 60.0;                                                                  // ступень задания
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// ref: d_kick.out_sp_step
AssertEquals_REAL(Expected := 60.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'SP step: only P = 10');
// ref: d_kick.d_sp_step
AssertEquals_REAL(Expected := 0.0, Actual := fbPid.stSts.rD_pct, Delta := 1.0E-4, Message := 'no derivative kick');
fbPid.rPv_eu := 52.0;                                                                  // ступень PV
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// ref: d_kick.d_pv_step
AssertEquals_REAL(Expected := -16.666666, Actual := fbPid.stSts.rD_pct, Delta := 1.0E-4, Message := 'D on PV step');
// ref: d_kick.out_pv_step
AssertEquals_REAL(Expected := 41.333332, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'out = 8 + 50 + D');
coUnit.TEST_FINISHED();
