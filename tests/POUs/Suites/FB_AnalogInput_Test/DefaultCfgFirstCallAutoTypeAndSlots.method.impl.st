coUnit.TEST('AnalogInput_DefaultCfg_FirstCallAutoTypeAndSlots');

fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wCfgErr, Message := 'default Cfg passes CheckConfig');
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Auto, Message := 'measurement after start');
AssertTrue(Condition := fbAi.stSts.stCommon.eDevType = E_DeviceType.AnalogInput, Message := 'device type');
AssertEquals_UINT(Expected := GVL_Const.AI_ALARM_COUNT, Actual := fbAi.AlarmCount, Message := 'alarm slots');
AssertEquals_UINT(Expected := 6, Actual := fbAi.AlarmCount, Message := 'six slots');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Good, Message := 'good');
AssertTrue(Condition := fbAi.Available, Message := 'available');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_MODE_AUTO) <> 0, Message := 'auto bit');
itfAlm := fbAi.GetAlarm(uiIndex := 6);
AssertTrue(Condition := itfAlm = 0, Message := 'no seventh slot');
AssertFalse(Condition := fbAi.RequestMode(eNewMode := E_DeviceMode.Local), Message := 'Local is not requested');

coUnit.TEST_FINISHED();
