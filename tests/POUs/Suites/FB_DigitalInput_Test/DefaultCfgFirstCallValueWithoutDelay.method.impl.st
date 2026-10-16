coUnit.TEST('DigitalInput_DefaultCfg_FirstCallValueWithoutDelay');

stCfg.tOnDelay := T#2S;
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbDi.stSts.stCommon.wCfgErr, Message := 'default Cfg passes CheckConfig');
AssertTrue(Condition := fbDi.xValue, Message := 'value without on-delay in the first call');
AssertTrue(Condition := fbDi.Mode = E_DeviceMode.Auto, Message := 'measurement after start');
AssertTrue(Condition := fbDi.stSts.stCommon.eDevType = E_DeviceType.DigitalInput, Message := 'device type');
AssertEquals_UINT(Expected := GVL_Const.DI_ALARM_COUNT, Actual := fbDi.AlarmCount, Message := 'two slots');
AssertTrue(Condition := fbDi.Status = E_Ne107Status.Good, Message := 'good');
AssertTrue(Condition := fbDi.Available, Message := 'available');
itfAlm := fbDi.GetAlarm(uiIndex := E_DiAlarm.State);
AssertTrue(Condition := itfAlm.State = E_AlarmState.Normal, Message := 'state alarm off by default');

coUnit.TEST_FINISHED();
