coUnit.TEST('Pid_SetpointRamp_RateLimited');
// источник: tools/reference/pid.py, сценарий sp_ramp
stCfg.rSpRate_ups := 2.0;
stCmd.rManualOut_pct := 30.0;
stCmd.rSp_eu := 40.0;
fbPid.rPv_eu := 40.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: задание 40 сразу
stCmd.rSp_eu := 60.0;
FOR iStep := 1 TO 50 DO                                                                // 5 с
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
rSp5 := fbPid.stSts.rSp_eu;
wSts5 := fbPid.stSts.stCommon.wStatus;
rTgt5 := fbPid.stSts.rSpTarget_eu;
FOR iStep := 1 TO 50 DO                                                                // ещё 5 с
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: sp_ramp.sp_5s
AssertEquals_REAL(Expected := 50.0, Actual := rSp5, Delta := 1.0E-4, Message := 'SP = 40 + 2 * 5 after 5 s');
AssertEquals_REAL(Expected := 60.0, Actual := rTgt5, Delta := 0.0, Message := 'target at once');
AssertEquals_WORD(Expected := GVL_Const.PID_STS_SP_RAMPING, Actual := wSts5 AND GVL_Const.PID_STS_SP_RAMPING,
                  Message := 'SP_RAMPING while ramping');
// ref: sp_ramp.sp_10s
AssertEquals_REAL(Expected := 60.0, Actual := fbPid.stSts.rSp_eu, Delta := 1.0E-4, Message := 'SP reached after 10 s');
AssertEquals_WORD(Expected := 0, Actual := fbPid.stSts.stCommon.wStatus AND GVL_Const.PID_STS_SP_RAMPING,
                  Message := 'SP_RAMPING cleared');
coUnit.TEST_FINISHED();
