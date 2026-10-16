coUnit.TEST('MotorVfd_FirstCallFakeTime_CommLossDeterministic');

stCfg.stVfd.tCommLoss := T#2S;
fbVfd.xCommOk := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 19, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault AND GVL_Const.MOT_FLT_COMM_LOSS,
                  Message := 'no comm fault at t0 + 1.9 s');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_COMM_LOSS, Actual := fbVfd.stSts.stCommon.wFault,
                  Message := 'comm fault exactly at t0 + 2.0 s of fake time');
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Fault, Message := 'state Fault');

coUnit.TEST_FINISHED();
