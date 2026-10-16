coUnit.TEST('ControlValve_PositionerFault_HoldAction');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbCv.rPosSpAuto_pct := 40.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbCv.xPositionerFault := TRUE;
fbCv.rPosSpAuto_pct := 70.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 40.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'held on fault');
AssertEquals_WORD(Expected := GVL_Const.CV_FLT_POSITIONER, Actual := fbCv.stSts.stCommon.wFault,
                  Message := 'POSITIONER');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.CV_STS_SAFE_POS,
                  Message := 'no SAFE_POS for Hold');
fbCv.xPositionerFault := FALSE;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 70.0, Actual := fbCv.rOut_pct, Delta := 0.0,
                  Message := 'follows setpoint after the fault');

coUnit.TEST_FINISHED();
