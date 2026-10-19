coUnit.TEST('Alarm_PriorityNoneWhileActive_EmitsClosingEvent');

GVL_Lib.itfAlarmSink := fbSink;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
udiSeq := fbAlm.udiSeq;
stCfg.ePriority := E_AlarmPriority.None;
fbTime.Advance(tStep := T#1S);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // выключена
stEv := fbSink.Last;
uiCnt := fbSink.Count;
fbTime.Advance(tStep := T#1S);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
GVL_Lib.itfAlarmSink := 0;
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Normal, Message := 'disabled alarm is Normal');
AssertEquals_UDINT(Expected := udiSeq + 1, Actual := fbAlm.udiSeq, Message := 'disabling is a transition');
AssertEquals_UINT(Expected := 2, Actual := uiCnt, Message := 'closing event sent');
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.Disabled, Message := 'reason Disabled');
AssertTrue(Condition := stEv.eOldState = E_AlarmState.ActiveUnack, Message := 'old state ActiveUnack');
AssertTrue(Condition := stEv.eNewState = E_AlarmState.Normal, Message := 'new state Normal');
AssertEquals_UINT(Expected := 2, Actual := fbSink.Count, Message := 'no further events while disabled');

coUnit.TEST_FINISHED();
