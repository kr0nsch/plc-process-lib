coUnit.TEST('Alarm_TimeBackwards_ShelveRemainNotExtended');

fbTime.SetNow(ltValue := LTIME#3H);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
fbAlm.Shelve(tDuration := T#1H);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // shelve до 4 ч
fbTime.SetNow(ltValue := LTIME#1H);                                                   // время назад на 2 ч
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertEquals_TIME(Expected := T#1H, Actual := fbAlm.tShelveRemain,
                  Message := 'remaining time limited to the shelve duration');
fbTime.Advance(tStep := T#59M);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Shelved, Message := 'still shelved after 59 min');
fbTime.Advance(tStep := T#1M);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'shelve ends 1 h after the new time');

coUnit.TEST_FINISHED();
