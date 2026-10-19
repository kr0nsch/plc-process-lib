coUnit.TEST('ControlValve_TightShut_BelowThresholdGivesZero');

stCfg.rTightShut_pct := 5.0;
stCmd.rPosSpMan_pct := 4.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// источник: tools/reference/valve_reference.py, сценарий cv_tight_ramp (out at sp 4, out at sp 6)
AssertEquals_REAL(Expected := 0.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'below threshold: 0 %');
AssertEquals_WORD(Expected := GVL_Const.CV_STS_TIGHT_SHUT,
                  Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.CV_STS_TIGHT_SHUT, Message := 'TIGHT_SHUT bit');
AssertEquals_REAL(Expected := 4.0, Actual := fbCv.rOut_mA, Delta := 1.0E-5, Message := '4 mA');
stCmd.rPosSpMan_pct := 6.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 6.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'above threshold: as set');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.CV_STS_TIGHT_SHUT,
                  Message := 'no TIGHT_SHUT');
stCfg.rRateUp_pctps := 1.0;
stCmd.rPosSpMan_pct := 0.0;
fbTime.Advance(tStep := T#100MS);
// спад без ограничения — сразу 0
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.rPosSpMan_pct := 20.0;
FOR iStep := 1 TO 9 DO                                                  // 4,5 с
    fbTime.Advance(tStep := T#500MS);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// источник: tools/reference/valve_reference.py, сценарий cv_tight_ramp (out 4.5 s, out 5.0 s, out 10.0 s)
AssertEquals_REAL(Expected := 0.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'ramp 4.5 % below threshold: 0 %');
fbTime.Advance(tStep := T#500MS);
// 5,0 с
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// источник: tools/reference/valve_reference.py, сценарий cv_tight_ramp (out 5.0 s, out 6.0 s); гистерезис CV-13
AssertEquals_REAL(Expected := 0.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'at threshold: still tight shut');
FOR iStep := 11 TO 12 DO                                                // 6,0 с
    fbTime.Advance(tStep := T#500MS);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_REAL(Expected := 6.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4, Message := 'released at +1 pct');
FOR iStep := 13 TO 20 DO                                                // 10,0 с
    fbTime.Advance(tStep := T#500MS);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_REAL(Expected := 10.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4,
                  Message := 'ramp not stuck under threshold');

coUnit.TEST_FINISHED();
