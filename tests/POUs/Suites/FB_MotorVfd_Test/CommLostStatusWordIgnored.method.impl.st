coUnit.TEST('MotorVfd_CommLost_StatusWordIgnored');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
fbVfd.xCommOk := FALSE;
fbVfd.xVfdFault := TRUE;
fbVfd.xVfdReady := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'stale fault bit ignored');
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wStatus AND GVL_Const.MOT_STS_PERMIT_MISSING,
                  Message := 'stale not-ready bit ignored');
fbVfd.xCommOk := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 3, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_EXT_FAULT, Actual := fbVfd.stSts.stCommon.wFault,
                  Message := 'VFD fault with comm');
AssertTrue(Condition := (fbVfd.stSts.stCommon.wStatus AND GVL_Const.MOT_STS_PERMIT_MISSING) <> 0,
           Message := 'not ready with comm');

coUnit.TEST_FINISHED();
