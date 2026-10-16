coUnit.TEST('Alarm_ShelveMaxZero_ShelveRejected');

stCfg.tShelveMax := T#0S;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
xRet := fbAlm.Shelve(tDuration := T#0S);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertFalse(Condition := xRet, Message := 'shelve rejected with tShelveMax = 0');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'alarm stays ActiveUnack');
AssertFalse(Condition := fbAlm.xShelved, Message := 'no shelve');
stCfg.tShelveMax := T#1H;
stCfg.ePriority := E_AlarmPriority.None;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
xRet := fbAlm.Shelve(tDuration := T#0S);
AssertFalse(Condition := xRet, Message := 'disabled alarm (priority None) rejects shelve');

coUnit.TEST_FINISHED();
