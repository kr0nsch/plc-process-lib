coUnit.TEST('Alarm_ActiveAckReturn_GoesNormal');

GVL_Lib.itfAlarmSink := fbSink;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
fbAlm.Ack();
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveAck
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);                               // условие ушло
GVL_Lib.itfAlarmSink := 0;
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Normal, Message := 'ActiveAck -> Normal');
AssertFalse(Condition := fbAlm.xInList, Message := 'removed from the alarm list');
stEv := fbSink.Last;
AssertTrue(Condition := stEv.eOldState = E_AlarmState.ActiveAck, Message := 'event old state ActiveAck');
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.Cleared, Message := 'event reason Cleared');
AssertEquals_UINT(Expected := 3, Actual := fbSink.Count, Message := 'three events');

coUnit.TEST_FINISHED();
