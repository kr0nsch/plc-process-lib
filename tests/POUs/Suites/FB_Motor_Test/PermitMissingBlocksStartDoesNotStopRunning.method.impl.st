coUnit.TEST('Motor_PermitMissing_BlocksStart_DoesNotStopRunning');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbMot.wPermit := 16#FFFE;
fbMot.xAutoRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQRun, Message := 'Auto request waits for permit');
AssertTrue(Condition := (fbMot.stSts.stCommon.wStatus AND GVL_Const.MOT_STS_PERMIT_MISSING) <> 0,
           Message := 'PERMIT_MISSING');
AssertEquals_WORD(Expected := 16#0001, Actual := fbMot.stSts.wPermitMissing, Message := 'missing permit bit');
AssertTrue(Condition := fbMot.Available, Message := 'missing permit keeps availability');
AssertFalse(Condition := fbMot.ReadyToStart, Message := 'not ready to start');
fbMot.wPermit := 16#FFFF;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQRun, Message := 'starts by itself when permit returns');
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.wPermit := 16#FFFE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQRun, Message := 'running motor not stopped by missing permit');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Running, Message := 'still running');
Spin(fbM := fbMot2, fbT := fbTime2, stC := stCmd2, stR := stRetain2, stF := stCfg, uiN := 1, tDt := T#0S);
fbMot2.wPermit := 16#7FFF;
stCmd2.xStart := TRUE;
Spin(fbM := fbMot2, fbT := fbTime2, stC := stCmd2, stR := stRetain2, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot2.stSts.stCommon.eCmdResult = E_CmdResult.RejectedPermit,
           Message := 'manual start rejected without permit');
AssertFalse(Condition := fbMot2.xQRun, Message := 'manual motor not started');

coUnit.TEST_FINISHED();
