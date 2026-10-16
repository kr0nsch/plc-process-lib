coUnit.TEST('Pid_PvFail_SafeOut_DrivesSafeOutput');
// источник: tools/reference/pid.py, сценарий safe_out
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCfg.ePvFailAction := E_PidPvFailAction.SafeOut;
stCfg.rSafeOut_pct := 15.0;
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
FOR iStep := 1 TO 5 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
rFail := fbPid.rOut_pct;
fbPid.xPvValid := TRUE;                                                                // PV вернулась
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rResume := fbPid.rOut_pct;
FOR iStep := 1 TO 2 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: safe_out.out_fail
AssertEquals_REAL(Expected := 15.0, Actual := rFail, Delta := 1.0E-4, Message := 'SafeOut: rSafeOut_pct');
// ref: safe_out.out_resume
AssertEquals_REAL(Expected := 15.0, Actual := rResume, Delta := 1.0E-4, Message := 'resume from safe output');
// ref: safe_out.out_resume_2
AssertEquals_REAL(Expected := 15.08, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'then integral action');
AssertTrue(Condition := fbPid.Mode = E_DeviceMode.Auto, Message := 'stays Auto');
coUnit.TEST_FINISHED();
