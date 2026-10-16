coUnit.TEST('Pid_PvFail_ShedToManual');
// источник: tools/reference/pid.py, сценарий pv_fail_hold (та же последовательность до отказа)
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCfg.ePvFailAction := E_PidPvFailAction.ShedToManual;
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
fbPid.xPvValid := FALSE;                                                               // отказ PV
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbPid.Mode = E_DeviceMode.Manual, Message := 'shed to Manual');
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Manual, Message := 'Manual remembered in retain');
// ref: pv_fail_hold.out_before
AssertEquals_REAL(Expected := 38.72, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'keeps current output');
AssertEquals_REAL(Expected := 38.72, Actual := stCmd.rManualOut_pct, Delta := 1.0E-4,
                  Message := 'Cmd holds the output');
AssertTrue(Condition := fbPid.Status = E_Ne107Status.Good, Message := 'no Failure in Manual');
AssertEquals_WORD(Expected := 0, Actual := fbPid.stSts.stCommon.wFault, Message := 'wFault 0 in Manual');
coUnit.TEST_FINISHED();
