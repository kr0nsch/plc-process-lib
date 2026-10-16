coUnit.TEST('Pid_DtGap_BoundaryAtTDtMax');
// источник: tools/reference/pid.py, сценарий dt_boundary
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCfg.tDtMax := T#1S;
stCmd.rManualOut_pct := 30.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto
fbPid.rPv_eu := 46.0;                                                                  // e = 4 %
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
rIBefore := fbPid.stSts.rI_pct;
fbTime.Advance(tStep := T#1S);                                                         // ровно tDtMax
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rIAtMax := fbPid.stSts.rI_pct;
rDtAtMax := fbPid.stSts.rDt_ms;
wStsMax := fbPid.stSts.stCommon.wStatus;
rOutMax := fbPid.rOut_pct;
fbTime.Advance(tStep := T#1001MS);                                                     // на 1 мс больше
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// ref: dt_boundary.i_before
AssertEquals_REAL(Expected := 30.8, Actual := rIBefore, Delta := 1.0E-4, Message := 'I before long steps');
// ref: dt_boundary.i_at_max
AssertEquals_REAL(Expected := 31.6, Actual := rIAtMax, Delta := 1.0E-4, Message := 'dt = tDtMax integrated (+0.8)');
// ref: dt_boundary.dt_ms_at_max
AssertEquals_REAL(Expected := 1000.0, Actual := rDtAtMax, Delta := 1.0E-3, Message := 'rDt_ms = 1000 at tDtMax');
AssertEquals_WORD(Expected := 0, Actual := wStsMax AND GVL_Const.PID_STS_DT_GAP, Message := 'no DT_GAP at tDtMax');
// ref: dt_boundary.i_over_max
AssertEquals_REAL(Expected := 30.8, Actual := fbPid.stSts.rI_pct, Delta := 1.0E-4,
                  Message := 'dt > tDtMax: init step presets I = u - P');
// ref: dt_boundary.out_over_max
AssertEquals_REAL(Expected := 38.8, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'gap: output held');
AssertEquals_REAL(Expected := rOutMax, Actual := fbPid.rOut_pct, Delta := 0.0,
                  Message := 'gap: exactly previous output');
AssertEquals_WORD(Expected := GVL_Const.PID_STS_DT_GAP,
                  Actual := fbPid.stSts.stCommon.wStatus AND GVL_Const.PID_STS_DT_GAP,
                  Message := 'DT_GAP above tDtMax');
AssertEquals_REAL(Expected := 0.0, Actual := fbPid.stSts.rDt_ms, Delta := 0.0, Message := 'rDt_ms = 0 on init step');
coUnit.TEST_FINISHED();
