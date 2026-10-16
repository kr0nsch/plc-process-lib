coUnit.TEST('Pid_AntiWindup_OutActNaN_UsesOwnOutput');
// источник: tools/reference/pid.py, сценарий outact_nan
uBits.dwValue := 16#7FC00000;                                                          // тихий NaN
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCfg.xUseOutAct := TRUE;
stCmd.rManualOut_pct := 30.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid.rOutAct_pct := uBits.rValue;                                                     // фактический выход неизвестен
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto
fbPid.rPv_eu := 46.0;                                                                  // e = 4 %
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rOut1 := fbPid.rOut_pct;
FOR iStep := 1 TO 50 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: outact_nan.out_first
AssertEquals_REAL(Expected := 38.0, Actual := rOut1, Delta := 1.0E-4, Message := 'first step: 30 + P');
// ref: outact_nan.out_after_5s
AssertEquals_REAL(Expected := 42.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'integral as usual');
// ref: outact_nan.i_after_5s
AssertEquals_REAL(Expected := 34.080002, Actual := fbPid.stSts.rI_pct, Delta := 1.0E-4, Message := 'integrator finite');
coUnit.TEST_FINISHED();
