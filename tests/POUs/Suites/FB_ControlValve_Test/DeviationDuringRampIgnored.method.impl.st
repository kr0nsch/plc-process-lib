coUnit.TEST('ControlValve_DeviationDuringRamp_Ignored');

stCfg.xFbUsed := TRUE;
stCfg.tDev := T#10S;
stCfg.rRateUp_pctps := 1.0;
fbCv.xPosFbValid := TRUE;
fbCv.rPosFb_pct := 0.0;
// t0: задание 0
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.rPosSpMan_pct := 50.0;
FOR iStep := 1 TO 50 DO                                                 // рампа 50 с
    fbTime.Advance(tStep := T#1S);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    xEverWarn := xEverWarn OR (fbCv.stSts.stCommon.wWarning AND GVL_Const.CV_WRN_DEVIATION) <> 0;
END_FOR
AssertFalse(Condition := xEverWarn, Message := 'no deviation supervision while ramping');
AssertEquals_REAL(Expected := 50.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4, Message := 'ramp finished at 50 %');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.CV_STS_RAMPING,
                  Message := 'RAMPING cleared');
FOR iStep := 1 TO 10 DO                                                 // 9 с после рампы
    fbTime.Advance(tStep := T#1S);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wWarning AND GVL_Const.CV_WRN_DEVIATION,
                  Message := 'no warning before tDev after the ramp');
fbTime.Advance(tStep := T#1S);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_WRN_DEVIATION,
                  Actual := fbCv.stSts.stCommon.wWarning AND GVL_Const.CV_WRN_DEVIATION,
                  Message := 'deviation once the ramp ended and tDev passed');

coUnit.TEST_FINISHED();
