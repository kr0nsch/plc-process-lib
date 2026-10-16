coUnit.TEST('Pid_RealDt_SameResultFor10msAnd100msSteps');
// источник: tools/reference/pid.py, сценарий real_dt
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCmdA.rManualOut_pct := 30.0;
stCmdA.rSp_eu := 50.0;
stCmdB := stCmdA;
fbPidA.rPv_eu := 50.0;
fbPidA.xPvValid := TRUE;
fbPidB.rPv_eu := 50.0;
fbPidB.xPvValid := TRUE;
fbPidA(itfTime := fbTimeA, stCmd := stCmdA, stRetain := stRetA, stCfg := stCfg);      // t0: Manual
fbPidB(itfTime := fbTimeB, stCmd := stCmdB, stRetain := stRetB, stCfg := stCfg);
fbTimeA.Advance(tStep := T#10MS);
fbTimeB.Advance(tStep := T#100MS);
stCmdA.stCommon.xSetAuto := TRUE;
stCmdB.stCommon.xSetAuto := TRUE;
fbPidA(itfTime := fbTimeA, stCmd := stCmdA, stRetain := stRetA, stCfg := stCfg);      // Auto
fbPidB(itfTime := fbTimeB, stCmd := stCmdB, stRetain := stRetB, stCfg := stCfg);
fbPidA.rPv_eu := 46.0;                                                                 // e = 4 %
fbPidB.rPv_eu := 46.0;
FOR iStep := 1 TO 500 DO                                                               // 5 с по 10 мс
    fbTimeA.Advance(tStep := T#10MS);
    fbPidA(itfTime := fbTimeA, stCmd := stCmdA, stRetain := stRetA, stCfg := stCfg);
END_FOR
FOR iStep := 1 TO 50 DO                                                                // 5 с по 100 мс
    fbTimeB.Advance(tStep := T#100MS);
    fbPidB(itfTime := fbTimeB, stCmd := stCmdB, stRetain := stRetB, stCfg := stCfg);
END_FOR
// ref: real_dt.i_10ms
AssertEquals_REAL(Expected := 34.0, Actual := fbPidA.stSts.rI_pct, Delta := 1.0E-4,
                  Message := 'I after 5 s, 10 ms steps');
// ref: real_dt.i_100ms
AssertEquals_REAL(Expected := 34.0, Actual := fbPidB.stSts.rI_pct, Delta := 1.0E-4,
                  Message := 'I after 5 s, 100 ms steps');
AssertEquals_REAL(Expected := fbPidB.stSts.rI_pct, Actual := fbPidA.stSts.rI_pct, Delta := 1.0E-4,
                  Message := 'same integral for both cycle times');
// ref: real_dt.out_10ms
AssertEquals_REAL(Expected := 41.992001, Actual := fbPidA.rOut_pct, Delta := 1.0E-4, Message := 'out, 10 ms steps');
// ref: real_dt.out_100ms
AssertEquals_REAL(Expected := 41.919998, Actual := fbPidB.rOut_pct, Delta := 1.0E-4, Message := 'out, 100 ms steps');
coUnit.TEST_FINISHED();
