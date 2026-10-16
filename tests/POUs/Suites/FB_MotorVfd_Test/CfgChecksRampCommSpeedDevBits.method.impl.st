coUnit.TEST('MotorVfd_CfgChecks_RampCommSpeedDevBits');

stCfg.stVfd.rRampUp_pctps := -1.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertEquals_WORD(Expected := GVL_Const.MOT_CFG_VFD_RAMP, Actual := fbVfd.stSts.stCommon.wCfgErr,
                  Message := 'bit 9 ramp');
stCfg.stVfd.rRampUp_pctps := 0.0;
stCfg.stVfd.tCommLoss := T#0S;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_CFG_VFD_COMM, Actual := fbVfd.stSts.stCommon.wCfgErr,
                  Message := 'bit 10 comm');
stCfg.stVfd.tCommLoss := T#3S;
stCfg.stVfd.rSpeedDev_pct := 5.0;
stCfg.stVfd.tSpeedDev := T#0S;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_CFG_VFD_SPEED_DEV, Actual := fbVfd.stSts.stCommon.wCfgErr,
                  Message := 'bit 11 deviation');
stCfg.stVfd.rSpeedDev_pct := 0.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wCfgErr, Message := 'deviation check off with 0');
stCfg.tResetWindow := T#0S;
stCfg.stVfd.rRampDown_pctps := -2.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
wExpected := GVL_Const.MOT_CFG_RESET OR GVL_Const.MOT_CFG_VFD_RAMP;
AssertEquals_WORD(Expected := wExpected, Actual := fbVfd.stSts.stCommon.wCfgErr,
                  Message := 'motor and VFD bits together');

coUnit.TEST_FINISHED();
