coUnit.TEST('Pid_SpTrackPv_InvalidPv_KeepsLastSetpoint');
stCfg.xSpTrackPv := TRUE;
stCmd.rManualOut_pct := 30.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 47.5;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual, задание = PV
fbPid.xPvValid := FALSE;                                                               // обрыв датчика
fbPid.rPv_eu := 0.0;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rCmdSpF := stCmd.rSp_eu;
rTgtF := fbPid.stSts.rSpTarget_eu;
fbPid.xPvValid := TRUE;                                                                // PV вернулась
fbPid.rPv_eu := 48.0;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 47.5, Actual := rCmdSpF, Delta := 0.0, Message := 'Cmd SP keeps last valid PV');
AssertEquals_REAL(Expected := 47.5, Actual := rTgtF, Delta := 0.0, Message := 'target keeps last valid PV');
AssertEquals_REAL(Expected := 48.0, Actual := stCmd.rSp_eu, Delta := 0.0, Message := 'follows PV again');
coUnit.TEST_FINISHED();
