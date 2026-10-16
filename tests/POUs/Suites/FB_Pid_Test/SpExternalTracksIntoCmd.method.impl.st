coUnit.TEST('Pid_SpExternal_TracksIntoCmd');
stCmd.rSp_eu := 20.0;                                                                  // операторское
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid.xSpExt := TRUE;
fbPid.rSpExt_eu := 63.0;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0
rCmdSp1 := stCmd.rSp_eu;
rTgt1 := fbPid.stSts.rSpTarget_eu;
fbPid.rSpExt_eu := 120.0;                                                              // выше rSpMax_eu
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 63.0, Actual := rCmdSp1, Delta := 0.0, Message := 'external SP written to Cmd');
AssertEquals_REAL(Expected := 63.0, Actual := rTgt1, Delta := 0.0, Message := 'target = external SP');
AssertEquals_REAL(Expected := 100.0, Actual := fbPid.stSts.rSpTarget_eu, Delta := 0.0,
                  Message := 'limited to rSpMax_eu');
fbPid.rSpExt_eu := 63.0;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbPid.xSpExt := FALSE;                                                                 // назад к оператору
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 63.0, Actual := stCmd.rSp_eu, Delta := 0.0, Message := 'operator SP keeps 63');
AssertEquals_REAL(Expected := 63.0, Actual := fbPid.stSts.rSp_eu, Delta := 0.0, Message := 'no setpoint bump');
coUnit.TEST_FINISHED();
