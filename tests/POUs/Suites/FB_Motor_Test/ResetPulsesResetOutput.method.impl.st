coUnit.TEST('Motor_Reset_PulsesResetOutput');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
uiSeqExp := fbMot.stSts.stCommon.uiCmdSeq + 1;
stCmd.stCommon.xReset := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQReset, Message := 'pulse starts with reset');
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'reset accepted');
AssertEquals_UINT(Expected := uiSeqExp, Actual := fbMot.stSts.stCommon.uiCmdSeq, Message := 'command counted');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 9, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQReset, Message := 'pulse held at 0.9 s');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQReset, Message := 'pulse ends at tResetPulse');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 25, tDt := T#100MS);
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted,
           Message := 'no RejectedFault without faults');
AssertEquals_UINT(Expected := uiSeqExp, Actual := fbMot.stSts.stCommon.uiCmdSeq, Message := 'single result');

coUnit.TEST_FINISHED();
