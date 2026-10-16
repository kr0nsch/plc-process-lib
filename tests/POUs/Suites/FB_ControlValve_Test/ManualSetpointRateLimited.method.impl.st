coUnit.TEST('ControlValve_ManualSetpoint_RateLimited');

stCfg.rRateUp_pctps := 10.0;
stCfg.rRateDown_pctps := 20.0;
// t0: задание 0
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.rPosSpMan_pct := 50.0;
FOR iStep := 1 TO 10 DO                                                 // t0 + 1,0 с
    fbTime.Advance(tStep := T#100MS);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// источник: tools/reference/valve_reference.py, сценарий cv_manual_ramp (up 1.0 s)
AssertEquals_REAL(Expected := 10.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4, Message := '10 % after 1 s');
AssertEquals_REAL(Expected := 50.0, Actual := fbCv.stSts.rPosSp_pct, Delta := 0.0, Message := 'setpoint before ramp');
AssertEquals_WORD(Expected := GVL_Const.CV_STS_RAMPING,
                  Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.CV_STS_RAMPING, Message := 'RAMPING bit');
AssertEquals_REAL(Expected := 50.0, Actual := stCmd.rPosSpMan_pct, Delta := 0.0,
                  Message := 'operator setpoint kept in Manual');
FOR iStep := 11 TO 49 DO                                                // t0 + 4,9 с
    fbTime.Advance(tStep := T#100MS);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// источник: tools/reference/valve_reference.py, сценарий cv_manual_ramp (up 4.9 s)
AssertEquals_REAL(Expected := 49.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4, Message := '49 % at 4.9 s');
fbTime.Advance(tStep := T#100MS);
// t0 + 5,0 с
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// источник: tools/reference/valve_reference.py, сценарий cv_manual_ramp (up 5.0 s)
AssertEquals_REAL(Expected := 50.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4, Message := '50 % at 5.0 s');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.CV_STS_RAMPING,
                  Message := 'ramp finished');
stCmd.rPosSpMan_pct := 10.0;
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// источник: tools/reference/valve_reference.py, сценарий cv_manual_ramp (down 1.0 s)
AssertEquals_REAL(Expected := 30.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4, Message := 'down 20 %/s: 30 % after 1 s');
FOR iStep := 11 TO 20 DO
    fbTime.Advance(tStep := T#100MS);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// источник: tools/reference/valve_reference.py, сценарий cv_manual_ramp (down 2.0 s, mA at 10 %)
AssertEquals_REAL(Expected := 10.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4, Message := '10 % after 2 s');
AssertEquals_REAL(Expected := 5.6, Actual := fbCv.rOut_mA, Delta := 1.0E-4, Message := '10 % = 5.6 mA');

coUnit.TEST_FINISHED();
