coUnit.TEST('Pid_TimeBackwards_InitStep_NoJump');
// источник: tools/reference/pid.py, сценарий time_back
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
fbTime.SetNow(ltValue := fbTime.Now() - LTIME#30S);                                    // время назад
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rBack := fbPid.rOut_pct;
wStsBack := fbPid.stSts.stCommon.wStatus;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rAfter := fbPid.rOut_pct;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// ref: time_back.out_before
AssertEquals_REAL(Expected := 38.72, Actual := rBefore, Delta := 1.0E-4, Message := 'output before time jump');
// ref: time_back.out_back
AssertEquals_REAL(Expected := 38.72, Actual := rBack, Delta := 1.0E-4, Message := 'time backwards: output held');
AssertEquals_WORD(Expected := GVL_Const.PID_STS_DT_GAP, Actual := wStsBack AND GVL_Const.PID_STS_DT_GAP,
                  Message := 'status bit DT_GAP');
// ref: time_back.out_after
AssertEquals_REAL(Expected := 38.72, Actual := rAfter, Delta := 1.0E-4, Message := 'first normal step');
// ref: time_back.out_after2
AssertEquals_REAL(Expected := 38.8, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'integration resumes');
coUnit.TEST_FINISHED();
