coUnit.TEST('Motor_StartsPerHour_LimitReached_InhibitsUntilWindowFrees');

stCfg.uiMaxStartsPerHour := 3;
stCfg.xFbUsed := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#1M);
stCmd.xStop := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 9, tDt := T#1M);
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#1M);
stCmd.xStop := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 9, tDt := T#1M);
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#1M);
stCmd.xStop := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 9, tDt := T#1M);
AssertEquals_UDINT(Expected := 3, Actual := stRetain.udiOpCount, Message := 'three starts');
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.RejectedInhibit,
           Message := 'fourth start rejected');
AssertFalse(Condition := fbMot.xQRun, Message := 'not started');
AssertEquals_UINT(Expected := 3, Actual := fbMot.stSts.uiStartsLastHour, Message := 'three starts in the window');
AssertEquals_UINT(Expected := 1800, Actual := fbMot.stSts.uiInhibitRemain_s, Message := 'window frees in 30 min');
AssertTrue(Condition := (fbMot.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_STARTS_LIMIT) <> 0,
           Message := 'STARTS_LIMIT warning');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 29, tDt := T#1M);
AssertEquals_UINT(Expected := 60, Actual := fbMot.stSts.uiInhibitRemain_s, Message := 'one minute left');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#1M);
AssertEquals_UINT(Expected := 2, Actual := fbMot.stSts.uiStartsLastHour, Message := 'first start left the window');
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'start accepted');
AssertTrue(Condition := fbMot.xQRun, Message := 'started');

coUnit.TEST_FINISHED();
