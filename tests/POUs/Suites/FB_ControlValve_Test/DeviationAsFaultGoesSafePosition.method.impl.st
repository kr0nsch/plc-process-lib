coUnit.TEST('ControlValve_DeviationAsFault_GoesSafePosition');

stCfg.xFbUsed := TRUE;
stCfg.xDevIsFault := TRUE;
stCfg.eFaultAction := E_CvFaultAction.SafePos;
stCfg.rSafePos_pct := 20.0;
stCfg.tDev := T#5S;
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbCv.rPosSpAuto_pct := 50.0;
fbCv.xPosFbValid := TRUE;
fbCv.rPosFb_pct := 50.0;
// Auto, 50 % (без рампы — сразу)
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCfg.rRateUp_pctps := 10.0;
stCfg.rRateDown_pctps := 10.0;
fbCv.rPosFb_pct := 30.0;
fbTime.Advance(tStep := T#1S);
// t1: клапан отстал
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 4 DO                                                  // t1 + 4 с
    fbTime.Advance(tStep := T#1S);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wFault, Message := 'no fault before tDev');
AssertEquals_REAL(Expected := 50.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'output 50 %');
fbTime.Advance(tStep := T#1S);
// t1 + 5 с
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_FLT_DEVIATION, Actual := fbCv.stSts.stCommon.wFault,
                  Message := 'deviation fault');
AssertTrue(Condition := fbCv.Status = E_Ne107Status.Failure, Message := 'NE 107 Failure');
AssertEquals_REAL(Expected := 20.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'safe position at once, no ramp');
AssertEquals_WORD(Expected := GVL_Const.CV_STS_SAFE_POS,
                  Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.CV_STS_SAFE_POS, Message := 'SAFE_POS bit');
AssertFalse(Condition := fbCv.xAutoActive, Message := 'PID must track');
fbCv.rPosFb_pct := 20.0;
fbTime.Advance(tStep := T#1S);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_FLT_DEVIATION, Actual := fbCv.stSts.stCommon.wFault, Message := 'latched');
stCmd.stCommon.xReset := TRUE;
// без шага времени
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wFault, Message := 'cleared by Reset');
AssertTrue(Condition := fbCv.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'Reset accepted');
AssertEquals_REAL(Expected := 20.0, Actual := fbCv.rOut_pct, Delta := 0.0,
                  Message := 'ramp starts from current output');
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// источник: tools/reference/valve_reference.py, сценарий cv_return_ramp (20 -> 50, 10 %/s, 1.0 s)
AssertEquals_REAL(Expected := 30.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4, Message := 'ramps back: 30 % after 1 s');
AssertTrue(Condition := fbCv.xAutoActive, Message := 'xAutoActive again');

coUnit.TEST_FINISHED();
