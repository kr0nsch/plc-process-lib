coUnit.TEST('Pid_SetpointNaN_HoldsTarget_Warns');
uBits.dwValue := 16#7FC00000;                                                          // тихий NaN
stCmd.rSp_eu := 55.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0
stCmd.rSp_eu := uBits.rValue;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rTgtNaN := fbPid.stSts.rSpTarget_eu;
wWrnNaN := fbPid.stSts.stCommon.wWarning;
wStsNaN := fbPid.stSts.stCommon.wStatus;
stCmd.rSp_eu := 60.0;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 55.0, Actual := rTgtNaN, Delta := 0.0, Message := 'NaN SP: previous target held');
AssertEquals_WORD(Expected := GVL_Const.PID_WRN_SP_INVALID, Actual := wWrnNaN, Message := 'warning SP_INVALID');
AssertEquals_WORD(Expected := GVL_Const.DEV_STS_WARNING, Actual := wStsNaN AND GVL_Const.DEV_STS_WARNING,
                  Message := 'common warning bit');
AssertEquals_REAL(Expected := 60.0, Actual := fbPid.stSts.rSpTarget_eu, Delta := 0.0, Message := 'finite SP accepted');
AssertEquals_WORD(Expected := 0, Actual := fbPid.stSts.stCommon.wWarning, Message := 'warning cleared');
coUnit.TEST_FINISHED();
