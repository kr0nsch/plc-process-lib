coUnit.TEST('ControlValve_InvalidCfgAtRuntime_KeepsLastValid');

stCfg.rRateUp_pctps := 10.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.rPosSpMan_pct := 50.0;
stCfg.rRateUp_pctps := -1.0;
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_RATE, Actual := fbCv.stSts.stCommon.wCfgErr, Message := 'CV_CFG_RATE');
AssertTrue(Condition := fbCv.Status = E_Ne107Status.CheckFunction, Message := 'NE 107 CheckFunction');
// источник: tools/reference/valve_reference.py, сценарий cv_manual_ramp (up 1.0 s)
AssertEquals_REAL(Expected := 10.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4, Message := 'ramp with last valid rate');

coUnit.TEST_FINISHED();
