coUnit.TEST('ControlValve_Interlock_SafePosBypassesRamp');

stCfg.rSafePos_pct := 10.0;
stCfg.rOutMin_pct := 20.0;
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbCv.rPosSpAuto_pct := 60.0;
// 60 %
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCfg.rRateUp_pctps := 1.0;
stCfg.rRateDown_pctps := 1.0;
fbCv.wInterlock := 16#0004;
fbTime.Advance(tStep := T#1S);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 10.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'safe position at once');
AssertEquals_WORD(Expected := GVL_Const.CV_STS_SAFE_POS OR GVL_Const.CV_STS_INTERLOCKED,
                  Actual := fbCv.stSts.stCommon.wStatus AND (GVL_Const.CV_STS_SAFE_POS OR GVL_Const.CV_STS_INTERLOCKED),
                  Message := 'SAFE_POS and INTERLOCKED bits');
AssertEquals_WORD(Expected := 16#0004, Actual := fbCv.stSts.wInterlock, Message := 'active interlocks');
AssertEquals_UINT(Expected := 2, Actual := fbCv.stSts.uiFirstOut, Message := 'first out bit 2');
AssertFalse(Condition := fbCv.xAutoActive, Message := 'PID must track');
AssertFalse(Condition := fbCv.Available, Message := 'not available');
AssertEquals_REAL(Expected := 10.0, Actual := stCmd.rPosSpMan_pct, Delta := 0.0,
                  Message := 'manual setpoint tracks the forced output');
fbCv.wInterlock := 16#0000;
fbTime.Advance(tStep := T#1S);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// источник: tools/reference/valve_reference.py, сценарий cv_return_ramp (10 -> 60, 1 %/s, 1 s)
AssertEquals_REAL(Expected := 11.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4,
                  Message := 'ramps back from safe position');
AssertTrue(Condition := fbCv.xAutoActive, Message := 'xAutoActive again');

coUnit.TEST_FINISHED();
