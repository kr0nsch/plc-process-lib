coUnit.TEST('Alarm_SuppressByDesign_NoAnnunciation');

GVL_Lib.itfAlarmSink := fbSink;
FOR iStep := 1 TO 10 DO
    fbAlm(xIn := TRUE, xSuppress := TRUE, stCfg := stCfg, itfTime := fbTime);
    fbTime.Advance(tStep := T#1S);
END_FOR
xRet := fbAlm.Ack();
AssertTrue(Condition := fbAlm.eState = E_AlarmState.SuppressedByDesign, Message := 'suppressed by design');
AssertFalse(Condition := fbAlm.xInList, Message := 'not in the alarm list');
AssertFalse(Condition := fbAlm.xUnacked, Message := 'no acknowledge needed');
AssertFalse(Condition := xRet, Message := 'Ack has no effect while suppressed');
AssertTrue(Condition := fbAlm.xActive, Message := 'xActive shows the condition');
AssertEquals_UDINT(Expected := 1, Actual := fbAlm.udiSeq, Message := 'one transition (Normal -> SuppressedByDesign)');
fbAlm(xIn := TRUE, xSuppress := FALSE, stCfg := stCfg, itfTime := fbTime);
GVL_Lib.itfAlarmSink := 0;
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack,
           Message := 'release with active condition -> ActiveUnack');
stEv := fbSink.Last;
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.Unsuppressed, Message := 'event reason Unsuppressed');

coUnit.TEST_FINISHED();
