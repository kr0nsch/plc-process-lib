coUnit.TEST('Motor_PowerDipWhileStopped_PauseFromPowerLoss');

stCfg.tMinStop := T#20S;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 250, tDt := T#100MS);
AssertEquals_UINT(Expected := 0, Actual := fbMot.stSts.uiInhibitRemain_s, Message := 'pause from PLC start over');
fbMot.xPowerOk := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 9, tDt := T#100MS);
fbMot.xPowerOk := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 41, tDt := T#100MS);
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.RejectedInhibit,
           Message := 'pause after power dip');
AssertEquals_UINT(Expected := 15, Actual := fbMot.stSts.uiInhibitRemain_s, Message := '15 s left');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 150, tDt := T#100MS);
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted,
           Message := 'start 20 s after power loss');

coUnit.TEST_FINISHED();
