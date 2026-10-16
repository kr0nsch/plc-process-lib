coUnit.TEST('Pid_PvFail_ShedToManual_DeferredWhileTracking');
stCfg.ePvFailAction := E_PidPvFailAction.ShedToManual;
stRetain.eRemoteMode := E_DeviceMode.Auto;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := FALSE;
fbPid.xTrack := TRUE;
fbPid.rTrack_pct := 33.0;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Auto, слежение, PV негодна
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
eModeTrk := fbPid.Mode;
fbPid.xTrack := FALSE;                                                                 // слежение снято
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := eModeTrk = E_DeviceMode.Auto, Message := 'stays Auto while tracking');
AssertTrue(Condition := fbPid.Mode = E_DeviceMode.Manual, Message := 'shed once tracking ends');
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Manual, Message := 'Manual in retain');
AssertEquals_REAL(Expected := 33.0, Actual := fbPid.rOut_pct, Delta := 0.0, Message := 'keeps tracked output');
AssertEquals_REAL(Expected := 33.0, Actual := stCmd.rManualOut_pct, Delta := 0.0, Message := 'Cmd holds the output');
coUnit.TEST_FINISHED();
