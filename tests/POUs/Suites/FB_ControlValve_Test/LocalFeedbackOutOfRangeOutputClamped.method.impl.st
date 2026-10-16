coUnit.TEST('ControlValve_LocalFeedbackOutOfRange_OutputClamped');

stCfg.xFbUsed := TRUE;
fbCv.xPosFbValid := TRUE;
fbCv.xLocal := TRUE;
fbCv.rPosFb_pct := -1.5;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbCv.Mode = E_DeviceMode.Local, Message := 'Local');
// источник: tools/reference/valve_reference.py, сценарий cv_local_clamp
AssertEquals_REAL(Expected := 0.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'feedback below 0: output 0 %');
AssertEquals_REAL(Expected := 4.0, Actual := fbCv.rOut_mA, Delta := 1.0E-5, Message := 'not below 4 mA');
fbCv.rPosFb_pct := 102.5;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 100.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'feedback above 100: 100 %');
AssertEquals_REAL(Expected := 20.0, Actual := fbCv.rOut_mA, Delta := 1.0E-5, Message := 'not above 20 mA');
AssertEquals_REAL(Expected := 100.0, Actual := stCmd.rPosSpMan_pct, Delta := 0.0,
                  Message := 'manual setpoint tracks 100');
stCfg.xOutInvert := TRUE;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 4.0, Actual := fbCv.rOut_mA, Delta := 1.0E-5, Message := 'inverted: 100 % = 4 mA');
fbCv.rPosFb_pct := -1.5;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 20.0, Actual := fbCv.rOut_mA, Delta := 1.0E-5, Message := 'inverted: 0 % = 20 mA');
fbCv.xLocal := FALSE;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbCv.Mode = E_DeviceMode.Manual, Message := 'back to Manual');
AssertEquals_REAL(Expected := 0.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'no bump from clamped output');

coUnit.TEST_FINISHED();
