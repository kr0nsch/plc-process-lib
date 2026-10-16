coUnit.TEST('Common_TestSink_RecordsEventsInOrder');

stEv1.udiId := 121;
stEv1.ePriority := E_AlarmPriority.High;
stEv1.eOldState := E_AlarmState.Normal;
stEv1.eNewState := E_AlarmState.ActiveUnack;
stEv1.eReason := E_AlarmEventReason.Activated;
stEv1.ltTime := LTIME#1H;
stEv1.rValue := 4.5;
stEv2 := stEv1;
stEv2.udiId := 122;
stEv2.eOldState := E_AlarmState.ActiveUnack;
stEv2.eNewState := E_AlarmState.ActiveAck;
stEv2.eReason := E_AlarmEventReason.Acked;
stEv2.ltTime := LTIME#2H;

GVL_Lib.itfAlarmSink := fbSink;
xAccepted := GVL_Lib.itfAlarmSink.OnAlarmEvent(stEvent := stEv1);
GVL_Lib.itfAlarmSink.OnAlarmEvent(stEvent := stEv2);
GVL_Lib.itfAlarmSink := 0;                                     // приёмник — снова 0

AssertTrue(Condition := xAccepted, Message := 'sink accepts the event');
AssertEquals_UINT(Expected := 2, Actual := fbSink.Count, Message := 'two events recorded');
stGot := fbSink.Last;
AssertEquals_UDINT(Expected := 122, Actual := stGot.udiId, Message := 'last event is the second one');
AssertTrue(Condition := stGot.eReason = E_AlarmEventReason.Acked, Message := 'last event reason Acked');
stGot := fbSink.GetEvent(uiBack := 1);
AssertEquals_UDINT(Expected := 121, Actual := stGot.udiId, Message := 'previous event is the first one');
AssertEquals_LTIME(Expected := LTIME#1H, Actual := stGot.ltTime, Message := 'event time stamp kept');
AssertEquals_REAL(Expected := 4.5, Actual := stGot.rValue, Delta := 0.0, Message := 'event value kept');
AssertTrue(Condition := GVL_Lib.itfAlarmSink = 0, Message := 'library sink restored to 0');

FOR uiEvent := 1 TO 33 DO
    stEv1.udiId := 1000 + uiEvent;
    fbSink.OnAlarmEvent(stEvent := stEv1);
END_FOR
AssertEquals_UINT(Expected := 35, Actual := fbSink.Count, Message := 'all events counted');
stGot := fbSink.Last;
AssertEquals_UDINT(Expected := 1033, Actual := stGot.udiId, Message := 'last of 33 events');
stGot := fbSink.GetEvent(uiBack := 31);
AssertEquals_UDINT(Expected := 1002, Actual := stGot.udiId, Message := 'the ring keeps the last 32 events');
stGot := fbSink.GetEvent(uiBack := 32);
AssertEquals_UDINT(Expected := 0, Actual := stGot.udiId, Message := 'older events are gone: empty event');

fbSink.Clear();
AssertEquals_UINT(Expected := 0, Actual := fbSink.Count, Message := 'Clear forgets all events');
stGot := fbSink.Last;
AssertEquals_UDINT(Expected := 0, Actual := stGot.udiId, Message := 'no last event after Clear');

coUnit.TEST_FINISHED();
