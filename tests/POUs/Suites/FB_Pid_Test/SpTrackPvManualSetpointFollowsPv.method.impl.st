coUnit.TEST('Pid_SpTrackPv_ManualSetpoint_FollowsPv');
// источник: tools/reference/pid.py, сценарий sp_track_pv
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCfg.xSpTrackPv := TRUE;
stCmd.rManualOut_pct := 30.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 47.5;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
FOR iStep := 1 TO 5 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
rCmdSp := stCmd.rSp_eu;
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Manual -> Auto
rOutSw := fbPid.rOut_pct;
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: sp_track_pv.cmd_sp
AssertEquals_REAL(Expected := 47.5, Actual := rCmdSp, Delta := 0.0, Message := 'SP follows PV in Manual');
// ref: sp_track_pv.out_switch
AssertEquals_REAL(Expected := 30.0, Actual := rOutSw, Delta := 1.0E-4, Message := 'no bump at Manual -> Auto');
// ref: sp_track_pv.out_1s
AssertEquals_REAL(Expected := 30.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'zero error after switch');
AssertEquals_REAL(Expected := 47.5, Actual := stCmd.rSp_eu, Delta := 0.0, Message := 'SP no longer written in Auto');
coUnit.TEST_FINISHED();
