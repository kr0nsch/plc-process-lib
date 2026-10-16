coUnit.TEST('ControlValve_Ramp_IndependentOfCycleTime');

stCfg.rRateUp_pctps := 10.0;
stCmdFast.rPosSpMan_pct := 80.0;
stCmdSlow.rPosSpMan_pct := 80.0;
fbFast(itfTime := fbTimeFast, stCmd := stCmdFast, stRetain := stRetainFast, stCfg := stCfg);
fbSlow(itfTime := fbTimeSlow, stCmd := stCmdSlow, stRetain := stRetainSlow, stCfg := stCfg);
FOR iStep := 1 TO 200 DO
    fbTimeFast.Advance(tStep := T#10MS);
    fbFast(itfTime := fbTimeFast, stCmd := stCmdFast, stRetain := stRetainFast, stCfg := stCfg);
END_FOR
FOR iStep := 1 TO 20 DO
    fbTimeSlow.Advance(tStep := T#100MS);
    fbSlow(itfTime := fbTimeSlow, stCmd := stCmdSlow, stRetain := stRetainSlow, stCfg := stCfg);
END_FOR
// источник: tools/reference/valve_reference.py, сценарий cv_cycle_independence: 20.00004 (10 мс) и 20.0 (100 мс)
AssertEquals_REAL(Expected := 20.0, Actual := fbFast.rOut_pct, Delta := 1.0E-4,
                  Message := '10 ms steps: 20 % after 2 s');
AssertEquals_REAL(Expected := 20.0, Actual := fbSlow.rOut_pct, Delta := 1.0E-4,
                  Message := '100 ms steps: 20 % after 2 s');

coUnit.TEST_FINISHED();
