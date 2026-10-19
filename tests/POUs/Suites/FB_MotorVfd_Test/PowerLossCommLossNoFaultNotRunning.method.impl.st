coUnit.TEST('MotorVfd_PowerLossCommLoss_NoFaultNotRunning');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbVfd.xAutoRun := TRUE;
fbVfd.rSpeedSpAuto_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#1S);
udiRun0 := stRetain.udiOpTime_s;
fbVfd.xPowerOk := FALSE;
fbVfd.xCommOk := FALSE;
fbVfd.xVfdRunning := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#1S);
AssertFalse(Condition := fbVfd.xRunning, Message := 'no power, no comm: not running');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 360, tDt := T#10S);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault,
                  Message := 'no CommLoss fault while power is lost');
itfAlm := fbVfd.GetAlarm(uiIndex := E_MotorAlarm.CommLoss);
AssertFalse(Condition := itfAlm.Active, Message := 'no CommLoss alarm');
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Stopped, Message := 'stopped without fault');
AssertTrue(Condition := stRetain.udiOpTime_s <= udiRun0 + 1, Message := 'run hours not counted in the outage');
fbVfd.xPowerOk := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 130, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault,
                  Message := 'no fault within boot allowance + tCommLoss (12.9 s)');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_COMM_LOSS, Actual := fbVfd.stSts.stCommon.wFault,
                  Message := 'comm fault at 13.0 s');
fbVfd.xCommOk := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'comm back: fault cleared');

coUnit.TEST_FINISHED();
