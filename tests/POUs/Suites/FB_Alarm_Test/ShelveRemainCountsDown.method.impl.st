coUnit.TEST('Alarm_ShelveRemain_CountsDown');

fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
fbAlm.Shelve(tDuration := T#1H);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // t0
fbTime.Advance(tStep := T#15M);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertEquals_TIME(Expected := T#45M, Actual := fbAlm.tShelveRemain, Message := '45 min left after 15 min');
fbTime.Advance(tStep := T#44M59S);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertEquals_TIME(Expected := T#1S, Actual := fbAlm.tShelveRemain, Message := '1 s left');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Shelved, Message := 'still shelved 1 s before the end');

coUnit.TEST_FINISHED();
