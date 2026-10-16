coUnit.TEST('Pid_POnly_ErrorStep_OutputEqualsKpTimesError');
// источник: tools/reference/pid.py, сценарий p_only
stCfg.rKp := 2.0;
stCfg.rTi_s := 0.0;
stCmd.rManualOut_pct := 40.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual, I := 40
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto, e = 0
// ref: p_only.out_switch
AssertEquals_REAL(Expected := 40.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'bumpless switch');
fbPid.rPv_eu := 45.0;                                                                  // e = +5 %
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// ref: p_only.out_e5
AssertEquals_REAL(Expected := 50.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'out = 40 + 2 * 5');
// ref: p_only.p_e5
AssertEquals_REAL(Expected := 10.0, Actual := fbPid.stSts.rP_pct, Delta := 1.0E-4, Message := 'P = Kp * e');
// ref: p_only.err_e5
AssertEquals_REAL(Expected := 5.0, Actual := fbPid.stSts.rErr_pct, Delta := 1.0E-4, Message := 'e = 5 %');
fbPid.rPv_eu := 53.0;                                                                  // e = -3 %
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// ref: p_only.out_em3
AssertEquals_REAL(Expected := 34.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'out = 40 - 2 * 3');
coUnit.TEST_FINISHED();
