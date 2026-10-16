coUnit.TEST('MotorVfd_InvalidSpeedLimits_CfgErrBit8');

stCfg.stVfd.rSpeedMin_pct := 50.0;
stCfg.stVfd.rSpeedMax_pct := 40.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertEquals_WORD(Expected := GVL_Const.MOT_CFG_VFD_SPEED_LIMITS, Actual := fbVfd.stSts.stCommon.wCfgErr,
                  Message := 'min >= max');
AssertTrue(Condition := fbVfd.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction');
stCfg.stVfd.rSpeedMin_pct := 0.0;
stCfg.stVfd.rSpeedMax_pct := 120.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_CFG_VFD_SPEED_LIMITS, Actual := fbVfd.stSts.stCommon.wCfgErr,
                  Message := 'max > 100');
stCfg.stVfd.rSpeedMin_pct := -1.0;
stCfg.stVfd.rSpeedMax_pct := 100.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_CFG_VFD_SPEED_LIMITS, Actual := fbVfd.stSts.stCommon.wCfgErr,
                  Message := 'min < 0');
stCfg.stVfd.rSpeedMin_pct := 0.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wCfgErr, Message := 'valid again');

coUnit.TEST_FINISHED();
