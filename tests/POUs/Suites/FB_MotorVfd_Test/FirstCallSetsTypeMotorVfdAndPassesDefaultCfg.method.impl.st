coUnit.TEST('MotorVfd_FirstCall_SetsTypeMotorVfdAndPassesDefaultCfg');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbVfd.stSts.stCommon.eDevType = E_DeviceType.MotorVfd, Message := 'eDevType = MotorVfd');
AssertEquals_UINT(Expected := 8, Actual := fbVfd.AlarmCount, Message := 'eight alarm slots');
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wCfgErr, Message := 'default Cfg passes CheckConfig');
AssertTrue(Condition := fbVfd.Status = E_Ne107Status.Good, Message := 'status Good');
AssertEquals_REAL(Expected := 0.0, Actual := fbVfd.rSpeedRef_pct, Delta := 0.0, Message := 'reference zero');

coUnit.TEST_FINISHED();
