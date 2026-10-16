coUnit.TEST('ControlValve_DeviationFaultReset_StuckValveRetripsAfterTDev');

stCfg.xFbUsed := TRUE;
stCfg.xDevIsFault := TRUE;
stCfg.tDev := T#5S;
stCmd.rPosSpMan_pct := 50.0;
fbCv.xPosFbValid := TRUE;
fbCv.rPosFb_pct := 30.0;
// выход 50 %, клапан стоит на 30 %
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// t0: первый вызов, в котором оценивается рассогласование (выход уже подан)
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 5 DO                                                  // t0 + 5 с
    fbTime.Advance(tStep := T#1S);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := GVL_Const.CV_FLT_DEVIATION, Actual := fbCv.stSts.stCommon.wFault,
                  Message := 'deviation fault');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wWarning AND GVL_Const.CV_WRN_DEVIATION,
                  Message := 'fault, not warning');
AssertEquals_REAL(Expected := 50.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'Hold keeps the output');
stCmd.stCommon.xReset := TRUE;
// t1: Reset, клапан всё так же на 30 %
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wFault, Message := 'cleared by Reset');
FOR iStep := 1 TO 4 DO                                                  // t1 + 4 с
    fbTime.Advance(tStep := T#1S);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wFault, Message := 'tDev restarted by Reset');
fbTime.Advance(tStep := T#1S);
// t1 + 5 с
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_FLT_DEVIATION, Actual := fbCv.stSts.stCommon.wFault,
                  Message := 'stuck valve trips again after tDev');

coUnit.TEST_FINISHED();
