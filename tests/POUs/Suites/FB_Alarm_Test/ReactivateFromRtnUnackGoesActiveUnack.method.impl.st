coUnit.TEST('Alarm_ReactivateFromRtnUnack_GoesActiveUnack');

GVL_Lib.itfAlarmSink := fbSink;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);                               // RtnUnack
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // снова
GVL_Lib.itfAlarmSink := 0;
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'RtnUnack -> ActiveUnack');
stEv := fbSink.Last;
AssertTrue(Condition := stEv.eOldState = E_AlarmState.RtnUnack, Message := 'event old state RtnUnack');
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.Activated, Message := 'event reason Activated');
AssertEquals_UDINT(Expected := 3, Actual := fbAlm.udiSeq, Message := 'three transitions');

coUnit.TEST_FINISHED();
