coUnit.TEST('Pid_AntiWindup_TtBelowDt_GainClampedToOne');
// источник: tools/reference/pid.py, сценарий tt_small
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCfg.rTt_s := 0.05;                                                                   // Tt < dt
stCmd.rManualOut_pct := 50.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto, I = 50 %
fbPid.rPv_eu := 0.0;                                                                   // e = +50 %, v = 150 %
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rOutSat := fbPid.rOut_pct;
rISat := fbPid.stSts.rI_pct;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rOutNext := fbPid.rOut_pct;
rINext := fbPid.stSts.rI_pct;
FOR iStep := 1 TO 8 DO                                                                 // до 1 с насыщения
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: tt_small.out_sat
AssertEquals_REAL(Expected := 100.0, Actual := rOutSat, Delta := 1.0E-4, Message := 'saturated at rOutMax_pct');
// ref: tt_small.i_sat
AssertEquals_REAL(Expected := 1.0, Actual := rISat, Delta := 1.0E-4,
                  Message := 'gain clamped to 1: I = 50 + 1 - 50, not -49');
// ref: tt_small.out_next
AssertEquals_REAL(Expected := 100.0, Actual := rOutNext, Delta := 1.0E-4,
                  Message := 'next step stays at limit (no back-calculation oscillation)');
// ref: tt_small.i_next
AssertEquals_REAL(Expected := 1.0, Actual := rINext, Delta := 1.0E-4, Message := 'I settles at v = u');
// ref: tt_small.out_1s
AssertEquals_REAL(Expected := 100.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'at limit after 1 s');
AssertTrue(Condition := fbPid.xSatHigh, Message := 'xSatHigh while saturated');
coUnit.TEST_FINISHED();
