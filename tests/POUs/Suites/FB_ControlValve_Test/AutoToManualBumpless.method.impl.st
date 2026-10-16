coUnit.TEST('ControlValve_AutoToManual_Bumpless');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbCv.rPosSpAuto_pct := 70.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 70.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'Auto 70 %');
AssertTrue(Condition := fbCv.xAutoActive, Message := 'xAutoActive');
AssertEquals_REAL(Expected := 70.0, Actual := stCmd.rPosSpMan_pct, Delta := 0.0,
                  Message := 'manual setpoint tracks in Auto');
stCfg.rRateUp_pctps := 5.0;
stCfg.rRateDown_pctps := 5.0;
stCmd.stCommon.xSetManual := TRUE;
fbCv.rPosSpAuto_pct := 20.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbCv.Mode = E_DeviceMode.Manual, Message := 'Manual');
AssertEquals_REAL(Expected := 70.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'no bump');
AssertFalse(Condition := fbCv.xAutoActive, Message := 'xAutoActive off in Manual');
stCmd.rPosSpMan_pct := 60.0;
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// источник: tools/reference/valve_reference.py, сценарий cv_bumpless (70 -> 60, 5 %/s, 1.0 s)
AssertEquals_REAL(Expected := 65.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4,
                  Message := 'ramp from 70 %: 65 % after 1 s');

coUnit.TEST_FINISHED();
