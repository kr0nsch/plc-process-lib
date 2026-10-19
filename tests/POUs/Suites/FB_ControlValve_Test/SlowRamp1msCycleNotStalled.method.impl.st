coUnit.TEST('ControlValve_SlowRamp1msCycle_NotStalled');

stCmd.rPosSpMan_pct := 70.0;
stCmd2.rPosSpMan_pct := 70.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Manual, 70 % без рампы
fbCv2(itfTime := fbTime2, stCmd := stCmd2, stRetain := stRet2, stCfg := stCfg);
stCfg.rRateUp_pctps := 0.003;
stCfg.rRateDown_pctps := 0.003;
stCmd.rPosSpMan_pct := 100.0;
stCmd2.rPosSpMan_pct := 100.0;
FOR iStep := 1 TO 1000 DO
    fbTime.AdvanceL(ltStep := LTIME#1MS);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
FOR iStep := 1 TO 10 DO
    fbTime2.Advance(tStep := T#100MS);
    fbCv2(itfTime := fbTime2, stCmd := stCmd2, stRetain := stRet2, stCfg := stCfg);
END_FOR
AssertEquals_REAL(Expected := 70.003, Actual := fbCv.rOut_pct, Delta := 1.0E-4, Message := '1 ms cycle: ramp moves');
AssertEquals_REAL(Expected := 70.003, Actual := fbCv2.rOut_pct, Delta := 1.0E-4, Message := '100 ms cycle: same');

coUnit.TEST_FINISHED();
