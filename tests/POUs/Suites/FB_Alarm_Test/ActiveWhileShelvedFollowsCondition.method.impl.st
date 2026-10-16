coUnit.TEST('Alarm_ActiveWhileShelved_FollowsCondition');

itfAlm := fbAlm;
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);
fbAlm.Shelve(tDuration := T#1H);
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);                               // Normal -> Shelved
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Shelved, Message := 'Normal -> Shelved');
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := itfAlm.Active, Message := 'Active follows the condition while shelved');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Shelved, Message := 'state stays Shelved');
AssertFalse(Condition := fbAlm.xInList, Message := 'not in the alarm list');
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);
AssertFalse(Condition := itfAlm.Active, Message := 'Active cleared with the condition');
AssertEquals_UDINT(Expected := 1, Actual := fbAlm.udiSeq, Message := 'only the shelve transition');

coUnit.TEST_FINISHED();
