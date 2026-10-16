coUnit.TEST('MotorVfd_CommLossNotFault_Warning');

stCfg.stVfd.xCommLossIsFault := FALSE;
stCfg.stVfd.xFbFromComm := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.rSpeedSp_pct := 50.0;
stCmd.xStart := TRUE;
fbVfd.xFbRun := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xCommOk := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 31, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'no fault');
AssertTrue(Condition := (fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_COMM_LOSS) <> 0,
           Message := 'COMM_LOSS warning');
AssertTrue(Condition := fbVfd.Status = E_Ne107Status.OutOfSpecification, Message := 'NE 107 S');
AssertTrue(Condition := fbVfd.xQRun, Message := 'still running');
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Running, Message := 'state Running');
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_FB_SUSPENDED,
                  Message := 'DI feedback still supervised');
itfAlm := fbVfd.GetAlarm(uiIndex := E_MotorAlarm.CommLoss);
AssertTrue(Condition := itfAlm.Active, Message := 'slot 6 alarm active');

coUnit.TEST_FINISHED();
