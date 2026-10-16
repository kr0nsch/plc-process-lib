coUnit.TEST('Motor_FirstCall_SetsTypeSlotsAndPassesDefaultCfg');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.stSts.stCommon.eDevType = E_DeviceType.Motor, Message := 'eDevType = Motor');
AssertEquals_UINT(Expected := 8, Actual := fbMot.AlarmCount, Message := 'eight alarm slots');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wCfgErr, Message := 'default Cfg passes CheckConfig');
AssertTrue(Condition := fbMot.Status = E_Ne107Status.Good, Message := 'status Good');
AssertTrue(Condition := fbMot.Mode = E_DeviceMode.Manual, Message := 'Manual from retain defaults');
AssertTrue(Condition := fbMot.stSts.eState = E_MotorState.Stopped, Message := 'stopped');
AssertFalse(Condition := fbMot.xQRun, Message := 'no run command');
AssertEquals_UINT(Expected := GVL_Const.NO_FIRST_OUT, Actual := fbMot.stSts.uiFirstOut, Message := 'no first out');
AssertFalse(Condition := fbMot.Available, Message := 'not available in Manual');

coUnit.TEST_FINISHED();
