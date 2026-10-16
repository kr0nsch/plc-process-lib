coUnit.TEST('ControlValve_InvalidCfg_StartupSafePosition');

stCfg.rOutMin_pct := 50.0;
stCfg.rOutMax_pct := 40.0;
stCfg.rSafePos_pct := 30.0;
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbCv.rPosSpAuto_pct := 70.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_LIMITS, Actual := fbCv.stSts.stCommon.wCfgErr,
                  Message := 'CV_CFG_LIMITS');
AssertTrue(Condition := fbCv.Status = E_Ne107Status.CheckFunction, Message := 'NE 107 CheckFunction');
AssertEquals_REAL(Expected := 30.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'safe position from cfg');
// источник: tools/reference/valve_reference.py, сценарий cv_ma (30 %)
AssertEquals_REAL(Expected := 8.8, Actual := fbCv.rOut_mA, Delta := 1.0E-5, Message := '30 % = 8.8 mA');
AssertEquals_WORD(Expected := GVL_Const.CV_STS_SAFE_POS,
                  Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.CV_STS_SAFE_POS, Message := 'SAFE_POS');
AssertFalse(Condition := fbCv.xAutoActive, Message := 'no xAutoActive without valid cfg');
AssertFalse(Condition := fbCv.Available, Message := 'not available');
AssertEquals_REAL(Expected := 30.0, Actual := stCmd.rPosSpMan_pct, Delta := 0.0, Message := 'manual setpoint tracks');
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_REAL(Expected := 30.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'stays at safe position');
uBits.dwValue := 16#7FC00000;
stCfgBad.rSafePos_pct := uBits.rValue;
fbCvBad(itfTime := fbTime, stCmd := stCmdBad, stRetain := stRetainBad, stCfg := stCfgBad);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_SAFE_POS, Actual := fbCvBad.stSts.stCommon.wCfgErr,
                  Message := 'CV_CFG_SAFE_POS');
AssertEquals_REAL(Expected := 0.0, Actual := fbCvBad.rOut_pct, Delta := 0.0, Message := 'NaN safe position: 0 %');
AssertEquals_REAL(Expected := 4.0, Actual := fbCvBad.rOut_mA, Delta := 1.0E-5, Message := '4 mA');
stCfgBad.rSafePos_pct := 150.0;
fbTime.Advance(tStep := T#100MS);
fbCvBad(itfTime := fbTime, stCmd := stCmdBad, stRetain := stRetainBad, stCfg := stCfgBad);
AssertEquals_REAL(Expected := 100.0, Actual := fbCvBad.rOut_pct, Delta := 0.0, Message := 'limited to 100 %');

coUnit.TEST_FINISHED();
