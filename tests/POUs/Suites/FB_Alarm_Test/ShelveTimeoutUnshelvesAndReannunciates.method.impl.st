coUnit.TEST('Alarm_Shelve_TimeoutUnshelvesAndReannunciates');

GVL_Lib.itfAlarmSink := fbSink;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
fbAlm.Ack();
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveAck
xRet := fbAlm.Shelve(tDuration := T#0S);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // t0: Shelved
AssertTrue(Condition := xRet, Message := 'shelve accepted');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Shelved, Message := 'ActiveAck -> Shelved');
AssertTrue(Condition := fbAlm.xShelved, Message := 'xShelved set');
AssertEquals_TIME(Expected := T#8H, Actual := fbAlm.tShelveRemain, Message := 'T#0S means tShelveMax = 8 h');
AssertFalse(Condition := fbAlm.xInList, Message := 'shelved alarm is not in the list');
FOR iStep := 1 TO 47 DO                                                               // до t0 + 7 ч 50 мин
    fbTime.Advance(tStep := T#10M);
    fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
END_FOR
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Shelved, Message := 'still shelved at 7 h 50 min');
AssertEquals_TIME(Expected := T#10M, Actual := fbAlm.tShelveRemain, Message := '10 min left');
fbTime.Advance(tStep := T#10M);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // t0 + 8 ч
GVL_Lib.itfAlarmSink := 0;
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'reannunciated as ActiveUnack after 8 h');
AssertFalse(Condition := fbAlm.xShelved, Message := 'shelve ended');
AssertEquals_TIME(Expected := T#0S, Actual := fbAlm.tShelveRemain, Message := 'no shelve time left');
stEv := fbSink.Last;
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.ShelveExpired, Message := 'event reason ShelveExpired');
AssertTrue(Condition := stEv.eOldState = E_AlarmState.Shelved, Message := 'event old state Shelved');

coUnit.TEST_FINISHED();
