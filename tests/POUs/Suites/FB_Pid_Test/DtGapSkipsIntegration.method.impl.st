coUnit.TEST('Pid_DtGap_SkipsIntegration');
// источник: tools/reference/pid.py, сценарий dt_gap
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
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
rBefore := fbPid.rOut_pct;
fbTime.Advance(tStep := T#5S);                                                         // разрыв
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rGap := fbPid.rOut_pct;
wStsGap := fbPid.stSts.stCommon.wStatus;
wWrnGap := fbPid.stSts.stCommon.wWarning;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rAfter := fbPid.rOut_pct;
wStsAfter := fbPid.stSts.stCommon.wStatus;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// ref: dt_gap.out_before
AssertEquals_REAL(Expected := 38.72, Actual := rBefore, Delta := 1.0E-4, Message := 'output before gap');
// ref: dt_gap.out_gap
AssertEquals_REAL(Expected := 38.72, Actual := rGap, Delta := 1.0E-4,
                  Message := 'gap: output held, no 5 s integration');
AssertEquals_WORD(Expected := GVL_Const.PID_STS_DT_GAP, Actual := wStsGap AND GVL_Const.PID_STS_DT_GAP,
                  Message := 'status bit DT_GAP on gap');
AssertEquals_WORD(Expected := GVL_Const.PID_WRN_DT_GAP, Actual := wWrnGap, Message := 'warning DT_GAP on gap');
// ref: dt_gap.out_after
AssertEquals_REAL(Expected := 38.72, Actual := rAfter, Delta := 1.0E-4, Message := 'first normal step after gap');
AssertEquals_WORD(Expected := 0, Actual := wStsAfter AND GVL_Const.PID_STS_DT_GAP, Message := 'DT_GAP for one call');
// ref: dt_gap.out_after2
AssertEquals_REAL(Expected := 38.8, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'integration resumes');
AssertEquals_WORD(Expected := 0, Actual := fbPid.stSts.stCommon.wWarning, Message := 'warning cleared');
coUnit.TEST_FINISHED();
