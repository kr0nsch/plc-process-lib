coUnit.TEST('Pid_ManualToAuto_Bumpless');
// источник: tools/reference/pid.py, сценарий manual_to_auto
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCfg.rTd_s := 1.0;
stCmd.rManualOut_pct := 35.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 47.0;                                                                  // e = 3 %
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
FOR iStep := 1 TO 10 DO                                                                // 1 с в Manual
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
rIManual := fbPid.stSts.rI_pct;
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Manual -> Auto
rOutSw := fbPid.rOut_pct;
FOR iStep := 1 TO 10 DO                                                                // 1 с в Auto
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: manual_to_auto.i_manual
AssertEquals_REAL(Expected := 29.0, Actual := rIManual, Delta := 1.0E-4, Message := 'I preset = u - P - D in Manual');
// ref: manual_to_auto.out_switch
AssertEquals_REAL(Expected := 35.0, Actual := rOutSw, Delta := 1.0E-4, Message := 'no bump at Manual -> Auto');
// ref: manual_to_auto.out_1s
AssertEquals_REAL(Expected := 35.599998, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'then integral action');
// ref: manual_to_auto.cmd_out_1s
AssertEquals_REAL(Expected := 35.599998, Actual := stCmd.rManualOut_pct, Delta := 1.0E-4,
                  Message := 'Cmd tracks output');
AssertTrue(Condition := fbPid.Mode = E_DeviceMode.Auto, Message := 'Auto');
coUnit.TEST_FINISHED();
