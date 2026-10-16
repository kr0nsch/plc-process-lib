coUnit.TEST('Pid_Track_PvMoving_NoDerivativeKickAtRelease');
// источник: tools/reference/pid.py, сценарий track_d
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCfg.rTd_s := 1.0;                                                                    // N = 10: Tf = 0,1 с
stRetain.eRemoteMode := E_DeviceMode.Auto;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid.xTrack := TRUE;
fbPid.rTrack_pct := 30.0;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Auto, слежение
FOR iStep := 1 TO 20 DO                                                                // 2 с, PV падает 2,5 %/с
    fbPid.rPv_eu := fbPid.rPv_eu - 0.25;
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
rDTrk := fbPid.stSts.rD_pct;
rITrk := fbPid.stSts.rI_pct;
rOutTrk := fbPid.rOut_pct;
fbPid.xTrack := FALSE;                                                                 // слежение снято
fbPid.rPv_eu := fbPid.rPv_eu - 0.25;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// ref: track_d.d_track
AssertEquals_REAL(Expected := 4.999995, Actual := rDTrk, Delta := 1.0E-4, Message := 'D works while tracking');
// ref: track_d.i_track
AssertEquals_REAL(Expected := 15.000005, Actual := rITrk, Delta := 1.0E-4, Message := 'I preset = u - P - D');
// ref: track_d.out_track
AssertEquals_REAL(Expected := 30.0, Actual := rOutTrk, Delta := 1.0E-4, Message := 'output = rTrack_pct');
// ref: track_d.out_release
AssertEquals_REAL(Expected := 30.500002, Actual := fbPid.rOut_pct, Delta := 1.0E-4,
                  Message := 'release: one-step change of P and D only, no derivative kick');
// ref: track_d.d_release
AssertEquals_REAL(Expected := 4.999998, Actual := fbPid.stSts.rD_pct, Delta := 1.0E-4, Message := 'D continues');
coUnit.TEST_FINISHED();
