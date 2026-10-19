coUnit.TEST('Motor_TimeBackwardsDuringMinStop_PauseRestarts');

stCfg.tMinStop := T#10S;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 100, tDt := T#100MS);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 11, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'precondition: running');
stCmd.xStop := TRUE;
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 20, tDt := T#100MS);
fbTime.SetNow(ltValue := fbTime.Now() - LTIME#30S);
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.RejectedInhibit,
           Message := 'start rejected: pause restarted after time went backwards');
AssertFalse(Condition := fbMot.xQRun, Message := 'not started');
AssertEquals_UINT(Expected := 10, Actual := fbMot.stSts.uiInhibitRemain_s, Message := 'full pause remains');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 99, tDt := T#100MS);
AssertEquals_UINT(Expected := 1, Actual := fbMot.stSts.uiInhibitRemain_s, Message := 'one second left at 9.9 s');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.xStart := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'start accepted after 10 s');

coUnit.TEST_FINISHED();
