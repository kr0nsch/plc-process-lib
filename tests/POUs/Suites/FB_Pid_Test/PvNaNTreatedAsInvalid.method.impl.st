coUnit.TEST('Pid_PvNaN_TreatedAsInvalid');
uBits.dwValue := 16#7FC00000;                                                          // тихий NaN
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCmd.rManualOut_pct := 30.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto, e = 0
fbPid.rPv_eu := uBits.rValue;                                                          // xPvValid остаётся TRUE
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
eStNaN := fbPid.Status;
wStsNaN := fbPid.stSts.stCommon.wStatus;
wFltNaN := fbPid.stSts.stCommon.wFault;
wAlmNaN := fbPid.stSts.stCommon.wAlmActive;
rOutNaN := fbPid.rOut_pct;
fbPid.rPv_eu := 50.0;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := eStNaN = E_Ne107Status.Failure, Message := 'NaN PV in Auto: Failure');
AssertEquals_WORD(Expected := GVL_Const.PID_STS_PV_FAIL, Actual := wStsNaN AND GVL_Const.PID_STS_PV_FAIL,
                  Message := 'status bit PV_FAIL');
AssertEquals_WORD(Expected := GVL_Const.PID_FLT_PV_INVALID, Actual := wFltNaN, Message := 'wFault PV_INVALID');
AssertEquals_WORD(Expected := 16#0001, Actual := wAlmNaN, Message := 'PvInvalid alarm active');
AssertEquals_REAL(Expected := 30.0, Actual := rOutNaN, Delta := 0.0, Message := 'Hold: output held');
AssertEquals_REAL(Expected := 30.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'resume without bump');
AssertTrue(Condition := fbPid.Status = E_Ne107Status.Good, Message := 'Good again');
coUnit.TEST_FINISHED();
