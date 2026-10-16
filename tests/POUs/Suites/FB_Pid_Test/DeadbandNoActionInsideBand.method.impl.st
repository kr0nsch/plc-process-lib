coUnit.TEST('Pid_Deadband_NoActionInsideBand');
// источник: tools/reference/pid.py, сценарий deadband
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCfg.rDeadband_pct := 1.0;
stCmd.rManualOut_pct := 30.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto
fbPid.rPv_eu := 49.2;                                                                  // e = 0,8 %
FOR iStep := 1 TO 20 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
rOutIn := fbPid.rOut_pct;
rErrIn := fbPid.stSts.rErr_pct;
wStsIn := fbPid.stSts.stCommon.wStatus;
fbPid.rPv_eu := 48.5;                                                                  // e = 1,5 %
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// ref: deadband.out_inside
AssertEquals_REAL(Expected := 30.0, Actual := rOutIn, Delta := 1.0E-4, Message := 'no action inside band');
// ref: deadband.err_inside
AssertEquals_REAL(Expected := 0.0, Actual := rErrIn, Delta := 1.0E-6, Message := 'e prime = 0 inside band');
AssertEquals_WORD(Expected := GVL_Const.PID_STS_IN_DEADBAND, Actual := wStsIn AND GVL_Const.PID_STS_IN_DEADBAND,
                  Message := 'status bit IN_DEADBAND');
// ref: deadband.out_outside
AssertEquals_REAL(Expected := 31.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'out = 30 + 2 * (1.5 - 1)');
// ref: deadband.err_outside
AssertEquals_REAL(Expected := 0.5, Actual := fbPid.stSts.rErr_pct, Delta := 1.0E-4, Message := 'e prime = e - band');
AssertEquals_WORD(Expected := 0, Actual := fbPid.stSts.stCommon.wStatus AND GVL_Const.PID_STS_IN_DEADBAND,
                  Message := 'IN_DEADBAND cleared');
coUnit.TEST_FINISHED();
