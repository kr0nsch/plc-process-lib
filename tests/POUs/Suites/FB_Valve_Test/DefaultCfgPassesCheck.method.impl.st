coUnit.TEST('Valve_DefaultCfg_PassesCheck');

fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wCfgErr, Message := 'default cfg passes');
AssertTrue(Condition := fbVlv.stSts.stCommon.eDevType = E_DeviceType.Valve, Message := 'eDevType Valve');
AssertEquals_UINT(Expected := 7, Actual := fbVlv.AlarmCount, Message := 'seven alarm slots');
itfAlm := fbVlv.GetAlarm(uiIndex := E_ValveAlarm.FailToOpen);
AssertTrue(Condition := itfAlm.AlarmPriority = E_AlarmPriority.Medium, Message := 'FailToOpen Medium');
itfAlm := fbVlv.GetAlarm(uiIndex := E_ValveAlarm.InterlockAct);
AssertTrue(Condition := itfAlm.AlarmPriority = E_AlarmPriority.None, Message := 'InterlockAct off by default');
itfAlm := fbVlv.GetAlarm(uiIndex := 7);
AssertTrue(Condition := itfAlm = 0, Message := 'slot 7 unused');
AssertTrue(Condition := fbVlv.Status = E_Ne107Status.Good, Message := 'NE 107 Good');

coUnit.TEST_FINISHED();
