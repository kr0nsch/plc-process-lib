coUnit.TEST('Alarm_Transition_SendsEventToSink');

stCfg.ePriority := E_AlarmPriority.High;
GVL_Lib.itfAlarmSink := fbSink;
fbAlm(xIn := FALSE, udiId := 4711, rValue := 12.5, stCfg := stCfg, itfTime := fbTime);
fbTime.Advance(tStep := T#1S);
fbAlm(xIn := TRUE, udiId := 4711, rValue := 12.5, stCfg := stCfg, itfTime := fbTime);  // Activated
ltAct := fbTime.Now();
fbAlm.Ack();
fbTime.Advance(tStep := T#2S);
fbAlm(xIn := TRUE, udiId := 4711, rValue := 13.0, stCfg := stCfg, itfTime := fbTime);  // Acked
GVL_Lib.itfAlarmSink := 0;
AssertEquals_UINT(Expected := 2, Actual := fbSink.Count, Message := 'one event per transition');
stEv := fbSink.GetEvent(uiBack := 1);
AssertEquals_UDINT(Expected := 4711, Actual := stEv.udiId, Message := 'event id');
AssertTrue(Condition := stEv.ePriority = E_AlarmPriority.High, Message := 'event priority');
AssertTrue(Condition := stEv.eOldState = E_AlarmState.Normal, Message := 'event old state');
AssertTrue(Condition := stEv.eNewState = E_AlarmState.ActiveUnack, Message := 'event new state');
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.Activated, Message := 'event reason');
AssertEquals_LTIME(Expected := ltAct, Actual := stEv.ltTime, Message := 'event time stamp');
AssertEquals_REAL(Expected := 12.5, Actual := stEv.rValue, Delta := 0.0, Message := 'event value');
stEv := fbSink.Last;
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.Acked, Message := 'second event: Acked');
AssertEquals_REAL(Expected := 13.0, Actual := stEv.rValue, Delta := 0.0, Message := 'value at the second event');
AssertTrue(Condition := GVL_Lib.itfAlarmSink = 0, Message := 'library sink restored to 0');

coUnit.TEST_FINISHED();
