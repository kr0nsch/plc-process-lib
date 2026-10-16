coUnit.TEST('ControlValve_Invert_20mAAtZero');

stCfg.xOutInvert := TRUE;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// источник: tools/reference/valve_reference.py, сценарий cv_ma
AssertEquals_REAL(Expected := 20.0, Actual := fbCv.rOut_mA, Delta := 1.0E-5, Message := '0 % = 20 mA inverted');
AssertEquals_REAL(Expected := 20.0, Actual := fbCv.stSts.rOut_mA, Delta := 1.0E-5, Message := 'Sts mA');
stCmd.rPosSpMan_pct := 25.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 16.0, Actual := fbCv.rOut_mA, Delta := 1.0E-5, Message := '25 % = 16 mA inverted');
stCmd.rPosSpMan_pct := 100.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 4.0, Actual := fbCv.rOut_mA, Delta := 1.0E-5, Message := '100 % = 4 mA inverted');
stCfg.xOutInvert := FALSE;
stCmd.rPosSpMan_pct := 25.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 8.0, Actual := fbCv.rOut_mA, Delta := 1.0E-5, Message := '25 % = 8 mA direct');

coUnit.TEST_FINISHED();
