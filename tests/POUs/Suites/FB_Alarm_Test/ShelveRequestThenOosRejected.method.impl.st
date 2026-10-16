coUnit.TEST('Alarm_ShelveRequestThenOos_Rejected');

fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
xRet := fbAlm.Shelve(tDuration := T#0S);
fbAlm(xIn := TRUE, xOutOfService := TRUE, stCfg := stCfg, itfTime := fbTime);         // запрос и OOS в одном вызове
AssertTrue(Condition := xRet, Message := 'request accepted by the method (alarm not yet OutOfService)');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.OutOfService, Message := 'alarm goes OutOfService');
AssertFalse(Condition := fbAlm.xShelved, Message := 'body rejects the shelve request under OutOfService');
AssertEquals_TIME(Expected := T#0S, Actual := fbAlm.tShelveRemain, Message := 'no shelve time');
fbTime.Advance(tStep := T#1M);
fbAlm(xIn := TRUE, xOutOfService := FALSE, stCfg := stCfg, itfTime := fbTime);        // выход из OOS
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack,
           Message := 'after OutOfService: ActiveUnack, not Shelved');

coUnit.TEST_FINISHED();
