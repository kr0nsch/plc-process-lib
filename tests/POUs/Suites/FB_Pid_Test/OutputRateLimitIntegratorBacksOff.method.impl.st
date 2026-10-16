coUnit.TEST('Pid_OutputRateLimit_IntegratorBacksOff');
// источник: tools/reference/pid.py, сценарий rate_limit
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCfg.rOutRate_pctps := 5.0;
stCmd.rManualOut_pct := 40.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto
stCmd.rSp_eu := 60.0;                                                                  // P: 0 -> 20 %
FOR iStep := 1 TO 20 DO                                                                // 2 с
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: rate_limit.out_2s
AssertEquals_REAL(Expected := 50.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'out = 40 + 5 %/s * 2 s');
// ref: rate_limit.i_2s
AssertEquals_REAL(Expected := 40.986393, Actual := fbPid.stSts.rI_pct, Delta := 1.0E-3, Message := 'I backs off');
AssertTrue(Condition := fbPid.stSts.rI_pct < 44.0, Message := 'I below plain integration 44 %');
AssertEquals_WORD(Expected := GVL_Const.PID_STS_OUT_RATE_LIMITED,
                  Actual := fbPid.stSts.stCommon.wStatus AND GVL_Const.PID_STS_OUT_RATE_LIMITED,
                  Message := 'status bit OUT_RATE_LIMITED');
coUnit.TEST_FINISHED();
