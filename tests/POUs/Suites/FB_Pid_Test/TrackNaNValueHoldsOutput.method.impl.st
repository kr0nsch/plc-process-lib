coUnit.TEST('Pid_Track_NaNValue_HoldsOutput');
uBits.dwValue := 16#7FC00000;                                                          // тихий NaN
stRetain.eRemoteMode := E_DeviceMode.Auto;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid.xTrack := TRUE;
fbPid.rTrack_pct := 25.0;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Auto, слежение
fbPid.rTrack_pct := uBits.rValue;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rOutNaN := fbPid.rOut_pct;
rCmdNaN := stCmd.rManualOut_pct;
fbPid.rTrack_pct := 40.0;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// AssertEquals_REAL пропускает NaN (ABS(NaN) > Delta = FALSE): конечность проверяется отдельно
AssertTrue(Condition := F_IsFinite(rIn := rOutNaN), Message := 'output stays finite');
AssertTrue(Condition := F_IsFinite(rIn := rCmdNaN), Message := 'Cmd output stays finite');
AssertEquals_REAL(Expected := 25.0, Actual := rOutNaN, Delta := 0.0, Message := 'NaN tracking value: output held');
AssertEquals_REAL(Expected := 25.0, Actual := rCmdNaN, Delta := 0.0, Message := 'Cmd keeps finite output');
AssertEquals_REAL(Expected := 40.0, Actual := fbPid.rOut_pct, Delta := 0.0, Message := 'finite value accepted');
coUnit.TEST_FINISHED();
