coUnit.TEST('ControlValve_FbInvalid_MaintenanceRequiredKeepsControl');

stCfg.xFbUsed := TRUE;
stCfg.tDev := T#5S;
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbCv.rPosSpAuto_pct := 30.0;
fbCv.xPosFbValid := FALSE;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_WRN_FB_INVALID, Actual := fbCv.stSts.stCommon.wWarning,
                  Message := 'FB_INVALID');
AssertTrue(Condition := fbCv.Status = E_Ne107Status.MaintenanceRequired, Message := 'NE 107 MaintenanceRequired');
AssertEquals_REAL(Expected := 30.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'control continues');
AssertTrue(Condition := fbCv.xAutoActive, Message := 'xAutoActive');
AssertTrue(Condition := fbCv.Available, Message := 'available');
itfAlm := fbCv.GetAlarm(uiIndex := E_CvAlarm.FbFailure);
AssertTrue(Condition := itfAlm.Active, Message := 'FbFailure alarm');
FOR iStep := 1 TO 10 DO                                                 // дольше tDev
    fbTime.Advance(tStep := T#1S);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wWarning AND GVL_Const.CV_WRN_DEVIATION,
                  Message := 'no deviation supervision without feedback');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wFault, Message := 'no fault');
fbCv.rPosSpAuto_pct := 60.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 60.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'follows new setpoint');
uBits.dwValue := 16#7FC00000;
fbCv.rPosFb_pct := uBits.rValue;
fbCv.xPosFbValid := TRUE;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_WRN_FB_INVALID,
                  Actual := fbCv.stSts.stCommon.wWarning AND GVL_Const.CV_WRN_FB_INVALID,
                  Message := 'NaN feedback invalid');
// AssertEquals_REAL пропускает NaN (ABS(NaN) > Delta = FALSE): конечность проверяется отдельно
AssertTrue(Condition := F_IsFinite(rIn := fbCv.rOut_pct) AND F_IsFinite(rIn := fbCv.rOut_mA),
           Message := 'output finite with NaN feedback');
AssertTrue(Condition := F_IsFinite(rIn := fbCv.stSts.rDeviation_pct), Message := 'deviation finite');
AssertEquals_REAL(Expected := 0.0, Actual := fbCv.stSts.rDeviation_pct, Delta := 0.0,
                  Message := 'no deviation without valid feedback (CV-8)');
AssertEquals_REAL(Expected := 60.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'control continues');

coUnit.TEST_FINISHED();
