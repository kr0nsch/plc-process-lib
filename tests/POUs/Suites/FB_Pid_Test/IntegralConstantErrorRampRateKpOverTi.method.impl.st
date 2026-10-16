coUnit.TEST('Pid_Integral_ConstantError_RampRateKpOverTi');
// источник: tools/reference/pid.py, сценарий integral
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCmd.rManualOut_pct := 30.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto
fbPid.rPv_eu := 46.0;                                                                  // e = 4 %
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rOutFirst := fbPid.rOut_pct;
FOR iStep := 1 TO 50 DO                                                                // ещё 5 с
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: integral.out_first
AssertEquals_REAL(Expected := 38.0, Actual := rOutFirst, Delta := 1.0E-4, Message := 'first step: P + I = 8 + 30');
// ref: integral.out_after_5s
AssertEquals_REAL(Expected := 42.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'output after 5 s');
// ref: integral.rate_pctps
AssertEquals_REAL(Expected := 0.8, Actual := (fbPid.rOut_pct - rOutFirst) / 5.0, Delta := 1.0E-4,
                  Message := 'ramp rate Kp * e / Ti = 0.8 %/s');
// ref: integral.i_after_5s
AssertEquals_REAL(Expected := 34.08, Actual := fbPid.stSts.rI_pct, Delta := 1.0E-4, Message := 'I after 51 updates');
coUnit.TEST_FINISHED();
