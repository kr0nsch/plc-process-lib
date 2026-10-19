coUnit.TEST('Motor_TimeBackwardsDuringResetPulse_PulseRestarts');

fbMot.xExtFault := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 5, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_EXT_FAULT, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'precondition: ExtFault latched');
stCmd.stCommon.xReset := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQReset, Message := 'precondition: reset pulse on');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 5, tDt := T#100MS);
fbTime.SetNow(ltValue := fbTime.Now() - LTIME#30S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.xQReset, Message := 'pulse not cut by time going backwards');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 9, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQReset, Message := 'pulse restarted: on at 0.9 s after the jump');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQReset, Message := 'pulse ends 1 s after the jump');
fbMot.xExtFault := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wFault,
                  Message := 'fault cleared in the restarted window');
AssertFalse(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.RejectedFault, Message := 'no RejectedFault');

coUnit.TEST_FINISHED();
