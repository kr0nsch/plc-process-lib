coUnit.TEST('ControlValve_AutoSpNaN_HoldsWithWarning');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbCv.rPosSpAuto_pct := 35.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
uBits.dwValue := 16#7FC00000;
fbCv.rPosSpAuto_pct := uBits.rValue;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 35.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'held on NaN setpoint');
AssertEquals_WORD(Expected := GVL_Const.CV_WRN_SP_INVALID,
                  Actual := fbCv.stSts.stCommon.wWarning AND GVL_Const.CV_WRN_SP_INVALID, Message := 'SP_INVALID');
fbCv.rPosSpAuto_pct := 45.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 45.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'follows a finite setpoint');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wWarning AND GVL_Const.CV_WRN_SP_INVALID,
                  Message := 'warning cleared');

coUnit.TEST_FINISHED();
