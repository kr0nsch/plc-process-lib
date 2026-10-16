coUnit.TEST('Alarm_OosEntry_ClearsUnack_ReannunciatesOnExit');

fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
fbAlm(xIn := TRUE, xOutOfService := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.OutOfService, Message := 'ActiveUnack -> OutOfService');
AssertFalse(Condition := fbAlm.xUnacked, Message := 'no unacknowledged alarm while out of service');
AssertFalse(Condition := fbAlm.xInList, Message := 'not in the alarm list');
fbAlm(xIn := TRUE, xOutOfService := FALSE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'exit with condition -> ActiveUnack');

fbAlm2(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
fbAlm2(xIn := TRUE, xOutOfService := TRUE, stCfg := stCfg, itfTime := fbTime);
fbAlm2(xIn := FALSE, xOutOfService := TRUE, stCfg := stCfg, itfTime := fbTime);
fbAlm2(xIn := FALSE, xOutOfService := FALSE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm2.eState = E_AlarmState.Normal, Message := 'exit without condition -> Normal');

coUnit.TEST_FINISHED();
