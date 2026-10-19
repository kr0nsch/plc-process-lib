coUnit.TEST('ControlValve_PositionerFault_SafePosAction');

stCfg.eFaultAction := E_CvFaultAction.SafePos;
stCfg.rSafePos_pct := 100.0;
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbCv.rPosSpAuto_pct := 40.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCfg.rRateUp_pctps := 2.0;
stCfg.rRateDown_pctps := 2.0;
fbCv.xPositionerFault := TRUE;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 100.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'safe position at once');
AssertEquals_WORD(Expected := GVL_Const.CV_FLT_POSITIONER, Actual := fbCv.stSts.stCommon.wFault,
                  Message := 'POSITIONER');
AssertTrue(Condition := fbCv.Status = E_Ne107Status.Failure, Message := 'NE 107 Failure');
AssertEquals_WORD(Expected := GVL_Const.CV_STS_SAFE_POS,
                  Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.CV_STS_SAFE_POS, Message := 'SAFE_POS');
AssertFalse(Condition := fbCv.xAutoActive, Message := 'PID must track');
fbCv.xPositionerFault := FALSE;
// без шага времени
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wFault, Message := 'not latched');
AssertEquals_REAL(Expected := 100.0, Actual := fbCv.rOut_pct, Delta := 0.0,
                  Message := 'ramp starts from safe position');
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// источник: tools/reference/valve_reference.py, сценарий cv_positioner (100 -> 40, 2 %/s, 1.0 s)
AssertEquals_REAL(Expected := 98.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4, Message := '98 % after 1 s');

coUnit.TEST_FINISHED();
