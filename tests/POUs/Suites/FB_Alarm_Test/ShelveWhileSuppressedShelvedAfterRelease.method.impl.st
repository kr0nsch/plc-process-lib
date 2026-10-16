coUnit.TEST('Alarm_ShelveWhileSuppressed_ShelvedAfterRelease');

fbAlm(xIn := TRUE, xSuppress := TRUE, stCfg := stCfg, itfTime := fbTime);             // SuppressedByDesign
GVL_Lib.itfAlarmSink := fbSink;
xRet := fbAlm.Shelve(tDuration := T#1H);
fbAlm(xIn := TRUE, xSuppress := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := xRet, Message := 'shelve accepted while suppressed');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.SuppressedByDesign, Message := 'suppression is senior to shelve');
AssertTrue(Condition := fbAlm.xShelved, Message := 'shelve running');
AssertEquals_UINT(Expected := 0, Actual := fbSink.Count, Message := 'no transition, no event');
fbAlm(xIn := TRUE, xSuppress := FALSE, stCfg := stCfg, itfTime := fbTime);
GVL_Lib.itfAlarmSink := 0;
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Shelved, Message := 'release -> Shelved');
stEv := fbSink.Last;
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.Unsuppressed, Message := 'event reason Unsuppressed');

coUnit.TEST_FINISHED();
