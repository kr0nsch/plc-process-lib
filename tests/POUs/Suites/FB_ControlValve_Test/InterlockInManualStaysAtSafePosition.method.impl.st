coUnit.TEST('ControlValve_InterlockInManual_StaysAtSafePosition');

stCfg.rSafePos_pct := 15.0;
stCmd.rPosSpMan_pct := 70.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 70.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'Manual 70 %');
fbCv.wInterlock := 16#0001;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 15.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'interlock: safe position');
AssertEquals_REAL(Expected := 15.0, Actual := stCmd.rPosSpMan_pct, Delta := 0.0,
                  Message := 'manual setpoint tracks the forced output');
fbCv.wInterlock := 16#0000;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbCv.Mode = E_DeviceMode.Manual, Message := 'still Manual');
AssertEquals_REAL(Expected := 15.0, Actual := fbCv.rOut_pct, Delta := 0.0,
                  Message := 'stays at safe position after the interlock clears');

coUnit.TEST_FINISHED();
