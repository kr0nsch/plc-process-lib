coUnit.TEST('Alarm_AckAndClearSameCall_TwoEventsInOrder');

fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
GVL_Lib.itfAlarmSink := fbSink;
fbAlm.Ack();
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);
GVL_Lib.itfAlarmSink := 0;
AssertEquals_UINT(Expected := 2, Actual := fbSink.Count, Message := 'two events in one call');
stEv := fbSink.GetEvent(uiBack := 1);
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.Acked, Message := 'first event: Acked');
AssertTrue(Condition := stEv.eNewState = E_AlarmState.ActiveAck, Message := 'first event: to ActiveAck');
stEv := fbSink.Last;
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.Cleared, Message := 'second event: Cleared');
AssertTrue(Condition := stEv.eOldState = E_AlarmState.ActiveAck, Message := 'second event: from ActiveAck');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Normal, Message := 'final state Normal');
AssertEquals_UDINT(Expected := 3, Actual := fbAlm.udiSeq, Message := 'udiSeq + 2 in one call');

coUnit.TEST_FINISHED();
