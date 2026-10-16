coUnit.TEST('Pid_SameTimestamp_NoCalc_HoldsOutput');
// источник: tools/reference/pid.py, сценарий dt_zero
stCfg.rKp := 1.0;
stCfg.rTi_s := 10.0;
stCfg.rTd_s := 2.0;                                                                    // N = 10: Tf = 0,2 с
stCmd.rManualOut_pct := 40.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto
FOR iStep := 1 TO 5 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
rOutBef := fbPid.rOut_pct;
rDBef := fbPid.stSts.rD_pct;
fbPid.rPv_eu := 49.0;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // то же время
rOutSame := fbPid.rOut_pct;
rDSame := fbPid.stSts.rD_pct;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// ref: dt_zero.out_before
AssertEquals_REAL(Expected := 40.0, Actual := rOutBef, Delta := 1.0E-4, Message := 'steady output');
// ref: dt_zero.d_before
AssertEquals_REAL(Expected := 0.0, Actual := rDBef, Delta := 1.0E-4, Message := 'no D at constant PV');
// ref: dt_zero.out_same
AssertEquals_REAL(Expected := 40.0, Actual := rOutSame, Delta := 1.0E-4, Message := 'dt = 0: output held');
// ref: dt_zero.d_same
AssertEquals_REAL(Expected := 0.0, Actual := rDSame, Delta := 1.0E-4, Message := 'dt = 0: no D spike');
// ref: dt_zero.out_next
AssertEquals_REAL(Expected := 47.666668, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'next step: P + I + D');
// ref: dt_zero.d_next
AssertEquals_REAL(Expected := 6.666667, Actual := fbPid.stSts.rD_pct, Delta := 1.0E-4, Message := 'PV step once');
// ref: dt_zero.dt_ms_next
AssertEquals_REAL(Expected := 100.0, Actual := fbPid.stSts.rDt_ms, Delta := 1.0E-3, Message := 'dt of the next step');
coUnit.TEST_FINISHED();
