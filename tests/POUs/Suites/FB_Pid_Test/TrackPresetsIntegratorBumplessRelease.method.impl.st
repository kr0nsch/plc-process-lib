coUnit.TEST('Pid_Track_PresetsIntegrator_BumplessRelease');
// источник: tools/reference/pid.py, сценарий track
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCfg.rOutMin_pct := 10.0;
stCfg.rSafeOut_pct := 10.0;                                                            // в пределах выхода (бит 11)
stRetain.eRemoteMode := E_DeviceMode.Auto;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 47.0;                                                                  // e = 3 %, P = 6
fbPid.xPvValid := TRUE;
fbPid.xTrack := TRUE;
fbPid.rTrack_pct := 0.0;                                                               // механизм стоит
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Auto, слежение
rOutTrk0 := fbPid.rOut_pct;
xTrkBit0 := (fbPid.stSts.stCommon.wStatus AND GVL_Const.PID_STS_TRACKING) <> 0;
fbPid.rTrack_pct := 25.0;
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: track.out_track0
AssertEquals_REAL(Expected := 0.0, Actual := rOutTrk0, Delta := 1.0E-4, Message := 'tracking ignores rOutMin_pct');
AssertTrue(Condition := xTrkBit0, Message := 'status bit TRACKING');
// ref: track.out_track
AssertEquals_REAL(Expected := 25.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'output = rTrack_pct');
// ref: track.i_track
AssertEquals_REAL(Expected := 19.0, Actual := fbPid.stSts.rI_pct, Delta := 1.0E-4, Message := 'I preset = 25 - 6');
AssertEquals_REAL(Expected := 25.0, Actual := stCmd.rManualOut_pct, Delta := 1.0E-4, Message := 'Cmd tracks output');
fbPid.xTrack := FALSE;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // слежение снято
rOutRel := fbPid.rOut_pct;
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: track.out_release
AssertEquals_REAL(Expected := 25.0, Actual := rOutRel, Delta := 1.0E-4, Message := 'no bump at release');
// ref: track.out_release_1s
AssertEquals_REAL(Expected := 25.6, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'then integral action');
AssertEquals_WORD(Expected := 0, Actual := fbPid.stSts.stCommon.wStatus AND GVL_Const.PID_STS_TRACKING,
                  Message := 'TRACKING cleared');
coUnit.TEST_FINISHED();
