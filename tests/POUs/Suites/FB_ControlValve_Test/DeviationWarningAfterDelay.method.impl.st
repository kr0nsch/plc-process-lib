coUnit.TEST('ControlValve_Deviation_WarningAfterDelay');

stCfg.xFbUsed := TRUE;
stCmd.rPosSpMan_pct := 50.0;
fbCv.xPosFbValid := TRUE;
fbCv.rPosFb_pct := 50.0;
// на задании
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_STS_AT_SETPOINT,
                  Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.CV_STS_AT_SETPOINT, Message := 'AT_SETPOINT');
fbCv.rPosFb_pct := 40.0;
fbTime.Advance(tStep := T#1S);
// t1: рассогласование 10 %
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 29 DO                                                 // t1 + 29 с
    fbTime.Advance(tStep := T#1S);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wWarning AND GVL_Const.CV_WRN_DEVIATION,
                  Message := 'no warning before tDev');
fbTime.Advance(tStep := T#1S);
// t1 + 30 с
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_WRN_DEVIATION,
                  Actual := fbCv.stSts.stCommon.wWarning AND GVL_Const.CV_WRN_DEVIATION,
Message := 'deviation warning');
AssertTrue(Condition := fbCv.Status = E_Ne107Status.OutOfSpecification, Message := 'NE 107 OutOfSpecification');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wFault, Message := 'warning, not fault');
AssertEquals_REAL(Expected := 50.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'control continues');
AssertEquals_REAL(Expected := 10.0, Actual := fbCv.stSts.rDeviation_pct, Delta := 1.0E-5, Message := 'deviation 10 %');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.CV_STS_AT_SETPOINT,
                  Message := 'not at setpoint');
itfAlm := fbCv.GetAlarm(uiIndex := E_CvAlarm.Deviation);
AssertTrue(Condition := itfAlm.Active, Message := 'Deviation alarm active');
fbCv.rPosFb_pct := 48.0;
fbTime.Advance(tStep := T#1S);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wWarning AND GVL_Const.CV_WRN_DEVIATION,
                  Message := 'warning clears within tolerance');
AssertEquals_WORD(Expected := GVL_Const.CV_STS_AT_SETPOINT,
                  Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.CV_STS_AT_SETPOINT,
Message := 'AT_SETPOINT again');
AssertTrue(Condition := fbCv.Status = E_Ne107Status.Good, Message := 'NE 107 Good');

coUnit.TEST_FINISHED();
