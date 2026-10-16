coUnit.TEST('Alarm_ShelveExpiresDuringSuppress_ReleaseGoesToBase');

stCfg.tShelveMax := T#1H;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
fbAlm.Shelve(tDuration := T#0S);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // Shelved на 1 ч
fbAlm(xIn := TRUE, xSuppress := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.SuppressedByDesign, Message := 'Shelved -> SuppressedByDesign');
fbTime.Advance(tStep := T#1H);
fbAlm(xIn := TRUE, xSuppress := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.SuppressedByDesign, Message := 'still suppressed');
AssertFalse(Condition := fbAlm.xShelved, Message := 'shelve expired during suppression');
fbAlm(xIn := TRUE, xSuppress := FALSE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'release -> ActiveUnack');

coUnit.TEST_FINISHED();
