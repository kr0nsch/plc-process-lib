coUnit.TEST('Pid_SetpointRamp_ResumesAfterPvFailure');
// источник: tools/reference/pid.py, сценарий sp_ramp_pv_fail
stCfg.rSpRate_ups := 2.0;
stCmd.rManualOut_pct := 30.0;
stCmd.rSp_eu := 40.0;
fbPid.rPv_eu := 40.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: задание 40 сразу
stCmd.rSp_eu := 60.0;
FOR iStep := 1 TO 20 DO                                                                // 2 с рампы
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
rSp2 := fbPid.stSts.rSp_eu;
fbPid.xPvValid := FALSE;
FOR iStep := 1 TO 10 DO                                                                // 1 с без PV
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
rSpFail := fbPid.stSts.rSp_eu;
fbPid.xPvValid := TRUE;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // PV вернулась
rSpResume := fbPid.stSts.rSp_eu;
wStsRes := fbPid.stSts.stCommon.wStatus;
FOR iStep := 1 TO 10 DO                                                                // ещё 1 с
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: sp_ramp_pv_fail.sp_2s
AssertEquals_REAL(Expected := 44.0, Actual := rSp2, Delta := 1.0E-4, Message := 'SP = 40 + 2 * 2 after 2 s');
// ref: sp_ramp_pv_fail.sp_fail
AssertEquals_REAL(Expected := 44.0, Actual := rSpFail, Delta := 1.0E-4, Message := 'ramp stops while PV invalid');
// ref: sp_ramp_pv_fail.sp_resume
AssertEquals_REAL(Expected := 44.0, Actual := rSpResume, Delta := 1.0E-4, Message := 'no jump to target on PV return');
AssertEquals_WORD(Expected := GVL_Const.PID_STS_SP_RAMPING, Actual := wStsRes AND GVL_Const.PID_STS_SP_RAMPING,
                  Message := 'SP_RAMPING on PV return');
// ref: sp_ramp_pv_fail.sp_resume_1s
AssertEquals_REAL(Expected := 46.0, Actual := fbPid.stSts.rSp_eu, Delta := 1.0E-4, Message := 'ramp resumes at 2 eu/s');
coUnit.TEST_FINISHED();
