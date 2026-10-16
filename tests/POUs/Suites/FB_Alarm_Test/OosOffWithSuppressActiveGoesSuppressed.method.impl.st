coUnit.TEST('Alarm_OosOffWithSuppressActive_GoesSuppressed');

fbAlm(xIn := TRUE, xSuppress := TRUE, xOutOfService := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.OutOfService, Message := 'OutOfService is senior to suppression');
GVL_Lib.itfAlarmSink := fbSink;
fbAlm(xIn := TRUE, xSuppress := TRUE, xOutOfService := FALSE, stCfg := stCfg, itfTime := fbTime);
GVL_Lib.itfAlarmSink := 0;
AssertTrue(Condition := fbAlm.eState = E_AlarmState.SuppressedByDesign,
           Message := 'OutOfService off -> SuppressedByDesign');
stEv := fbSink.Last;
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.OosOff, Message := 'event reason OosOff');

coUnit.TEST_FINISHED();
