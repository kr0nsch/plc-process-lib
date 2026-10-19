coUnit.TEST('MotorVfd_CommLoss_CountersFrozen');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbVfd.xAutoRun := TRUE;
fbVfd.rSpeedSpAuto_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 50.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#1S);
udiRun0 := stRetain.udiOpTime_s;
udiCnt0 := stRetain.udiOpCount;
AssertTrue(Condition := udiRun0 >= 9, Message := 'precondition: run hours counted');
fbVfd.xCommOk := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 5, tDt := T#1S);
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 360, tDt := T#10S);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_COMM_LOSS, Actual := fbVfd.stSts.stCommon.wFault,
                  Message := 'comm fault');
AssertFalse(Condition := fbVfd.xRunning, Message := 'not running by stale feedback');
AssertFalse(Condition := fbVfd.Running, Message := 'Running property FALSE');
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wStatus AND GVL_Const.MOT_STS_RUNNING,
                  Message := 'RUNNING bit cleared');
AssertTrue(Condition := stRetain.udiOpTime_s <= udiRun0 + 4, Message := 'run hours frozen after tCommLoss');
AssertEquals_UDINT(Expected := 0, Actual := fbVfd.CurrentRunSeconds, Message := 'current run reset');
fbVfd.xCommOk := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#1S);
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wFault, Message := 'comm fault cleared');
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Running, Message := 'running: drive kept running');
AssertEquals_UDINT(Expected := udiCnt0, Actual := stRetain.udiOpCount, Message := 'regained feedback is not a start');

coUnit.TEST_FINISHED();
