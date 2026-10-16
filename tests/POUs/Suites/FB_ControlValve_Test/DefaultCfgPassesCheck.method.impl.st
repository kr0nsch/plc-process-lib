coUnit.TEST('ControlValve_DefaultCfg_PassesCheck');

fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wCfgErr, Message := 'default cfg passes');
AssertTrue(Condition := fbCv.stSts.stCommon.eDevType = E_DeviceType.ControlValve, Message := 'eDevType ControlValve');
AssertEquals_UINT(Expected := 4, Actual := fbCv.AlarmCount, Message := 'four alarm slots');
itfAlm := fbCv.GetAlarm(uiIndex := E_CvAlarm.PositionerFault);
AssertTrue(Condition := itfAlm.AlarmPriority = E_AlarmPriority.Medium, Message := 'PositionerFault Medium');
itfAlm := fbCv.GetAlarm(uiIndex := E_CvAlarm.InterlockAct);
AssertTrue(Condition := itfAlm.AlarmPriority = E_AlarmPriority.None, Message := 'InterlockAct off by default');
itfAlm := fbCv.GetAlarm(uiIndex := 4);
AssertTrue(Condition := itfAlm = 0, Message := 'slot 4 unused');
AssertEquals_REAL(Expected := 4.0, Actual := fbCv.rOut_mA, Delta := 1.0E-5, Message := '4 mA at 0 %');
AssertFalse(Condition := fbCv.xAutoActive, Message := 'no xAutoActive in Manual');
AssertTrue(Condition := fbCv.Status = E_Ne107Status.Good, Message := 'NE 107 Good');

coUnit.TEST_FINISHED();
