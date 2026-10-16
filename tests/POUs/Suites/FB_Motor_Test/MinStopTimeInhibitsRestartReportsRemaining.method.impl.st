coUnit.TEST('Motor_MinStopTime_InhibitsRestart_ReportsRemaining');

stCfg.tMinStop := T#30S;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertEquals_UINT(Expected := 30, Actual := fbMot.stSts.uiInhibitRemain_s, Message := 'pause from PLC start');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 300, tDt := T#100MS);
AssertEquals_UINT(Expected := 0, Actual := fbMot.stSts.uiInhibitRemain_s, Message := 'pause over');
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#100MS);
stCmd.xStop := TRUE;
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_UINT(Expected := 30, Actual := fbMot.stSts.uiInhibitRemain_s, Message := 'full pause at stop');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 123, tDt := T#100MS);
AssertEquals_UINT(Expected := 18, Actual := fbMot.stSts.uiInhibitRemain_s, Message := 'remaining rounded up');
AssertTrue(Condition := (fbMot.stSts.stCommon.wStatus AND GVL_Const.MOT_STS_START_INHIBIT) <> 0,
           Message := 'START_INHIBIT');
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.RejectedInhibit,
           Message := 'start rejected in pause');
AssertFalse(Condition := fbMot.xQRun, Message := 'not started');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 176, tDt := T#100MS);
AssertEquals_UINT(Expected := 1, Actual := fbMot.stSts.uiInhibitRemain_s, Message := 'one second left');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_UINT(Expected := 0, Actual := fbMot.stSts.uiInhibitRemain_s, Message := 'pause over at 30 s');
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted,
           Message := 'start accepted after pause');
AssertTrue(Condition := fbMot.xQRun, Message := 'started');

coUnit.TEST_FINISHED();
