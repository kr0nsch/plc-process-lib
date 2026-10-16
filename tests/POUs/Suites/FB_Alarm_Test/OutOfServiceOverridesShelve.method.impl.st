coUnit.TEST('Alarm_OutOfService_OverridesShelve');

GVL_Lib.itfAlarmSink := fbSink;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
fbAlm.Shelve(tDuration := T#1H);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // t0: Shelved
fbAlm(xIn := TRUE, xOutOfService := TRUE, stCfg := stCfg, itfTime := fbTime);         // OutOfService
stEv := fbSink.Last;
xRet := fbAlm.Shelve(tDuration := T#0S);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.OutOfService, Message := 'OutOfService overrides Shelved');
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.OosOn, Message := 'event reason OosOn');
AssertTrue(Condition := fbAlm.xShelved, Message := 'shelve still running under OutOfService');
AssertFalse(Condition := xRet, Message := 'shelve rejected in OutOfService');
fbTime.Advance(tStep := T#20M);
fbAlm(xIn := TRUE, xOutOfService := FALSE, stCfg := stCfg, itfTime := fbTime);        // t0 + 20 мин
stEv := fbSink.Last;
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Shelved, Message := 'back to Shelved after OutOfService');
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.OosOff, Message := 'event reason OosOff');
AssertEquals_TIME(Expected := T#40M, Actual := fbAlm.tShelveRemain, Message := 'shelve counted from the command');
fbAlm(xIn := TRUE, xOutOfService := TRUE, stCfg := stCfg, itfTime := fbTime);
fbTime.Advance(tStep := T#50M);
fbAlm(xIn := TRUE, xOutOfService := TRUE, stCfg := stCfg, itfTime := fbTime);         // срок истёк в OOS
AssertTrue(Condition := fbAlm.eState = E_AlarmState.OutOfService, Message := 'still OutOfService');
AssertFalse(Condition := fbAlm.xShelved, Message := 'shelve expired under OutOfService');
fbAlm(xIn := TRUE, xOutOfService := FALSE, stCfg := stCfg, itfTime := fbTime);
GVL_Lib.itfAlarmSink := 0;
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack,
           Message := 'exit with active condition -> ActiveUnack');

coUnit.TEST_FINISHED();
