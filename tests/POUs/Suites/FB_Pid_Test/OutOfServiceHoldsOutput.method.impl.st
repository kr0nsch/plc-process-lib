coUnit.TEST('Pid_OutOfService_HoldsOutput');
// источник: tools/reference/pid.py, сценарий oos
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
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetOos := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // в OutOfService
rOutOos := fbPid.rOut_pct;
eResOos := fbPid.stSts.stCommon.eCmdResult;
fbPid.rPv_eu := 30.0;                                                                  // PV меняется
FOR iStep := 1 TO 30 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: oos.out_oos
AssertEquals_REAL(Expected := 38.72, Actual := rOutOos, Delta := 1.0E-4, Message := 'OOS entry keeps output');
AssertTrue(Condition := eResOos = E_CmdResult.Accepted, Message := 'xSetOos accepted');
// ref: oos.out_oos_3s
AssertEquals_REAL(Expected := 38.72, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'held in OOS');
AssertEquals_REAL(Expected := 38.72, Actual := stCmd.rManualOut_pct, Delta := 1.0E-4, Message := 'Cmd tracks output');
AssertTrue(Condition := fbPid.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction in OOS');
AssertTrue(Condition := stRetain.xOutOfService, Message := 'OOS in retain');
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // выход из OOS
rOutExit := fbPid.rOut_pct;
wWrnExit := fbPid.stSts.stCommon.wWarning;
FOR iStep := 1 TO 2 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: oos.out_exit
AssertEquals_REAL(Expected := 38.72, Actual := rOutExit, Delta := 1.0E-4, Message := 'no bump on OOS exit');
AssertEquals_WORD(Expected := 0, Actual := wWrnExit, Message := 'OOS exit is not a time gap');
// ref: oos.out_exit_2
AssertEquals_REAL(Expected := 39.12, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'control resumes, e = 20 %');
coUnit.TEST_FINISHED();
