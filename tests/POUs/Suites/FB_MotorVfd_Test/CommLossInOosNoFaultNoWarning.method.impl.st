coUnit.TEST('MotorVfd_CommLossInOos_NoFaultNoWarning');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetOos := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.Mode = E_DeviceMode.OutOfService, Message := 'out of service');
fbVfd.xCommOk := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 40, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'no comm fault in OOS');
stCfg.stVfd.xCommLossIsFault := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 2, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_COMM_LOSS,
                  Message := 'no comm warning in OOS');
itfAlm := fbVfd.GetAlarm(uiIndex := E_MotorAlarm.CommLoss);
AssertTrue(Condition := itfAlm.State = E_AlarmState.OutOfService, Message := 'slot 6 out of service');
stCmd.stCommon.xSetManual := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 2, tDt := T#100MS);
AssertTrue(Condition := (fbVfd.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_COMM_LOSS) <> 0,
           Message := 'comm warning in Manual');

coUnit.TEST_FINISHED();
