coUnit.TEST('Motor_CfgChecks_SetEachCfgErrBit');

stCfg.tFbStart := T#0S;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertEquals_WORD(Expected := GVL_Const.MOT_CFG_FB_TIMES, Actual := fbMot.stSts.stCommon.wCfgErr,
                  Message := 'bit 0 FB_TIMES');
stCfg.tFbStart := T#5S;
stCfg.uiMaxStartsPerHour := 31;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_CFG_STARTS_LIMIT, Actual := fbMot.stSts.stCommon.wCfgErr,
                  Message := 'bit 1 STARTS');
stCfg.uiMaxStartsPerHour := 30;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wCfgErr, Message := '30 starts per hour allowed');
stCfg.tResetPulse := T#4S;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_CFG_RESET, Actual := fbMot.stSts.stCommon.wCfgErr,
                  Message := 'bit 2 RESET');
stCfg.tResetPulse := T#3S;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wCfgErr, Message := 'pulse equal to window allowed');
uBad.iValue := 7;
SetSlotPriority(stCfgMot := stCfg, uiSlot := 0, ePrioSlot := uBad.ePriority);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_CFG_ALARM, Actual := fbMot.stSts.stCommon.wCfgErr,
                  Message := 'bit 3 ALARM');
SetSlotPriority(stCfgMot := stCfg, uiSlot := 0, ePrioSlot := E_AlarmPriority.Medium);
stCfg.xFbUsed := FALSE;
stCfg.tFbStop := T#0S;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wCfgErr,
                  Message := 'feedback times ignored without feedback');

coUnit.TEST_FINISHED();
