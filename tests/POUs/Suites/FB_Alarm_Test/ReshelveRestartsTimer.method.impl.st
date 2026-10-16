coUnit.TEST('Alarm_Reshelve_RestartsTimer');

fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
fbAlm.Shelve(tDuration := T#1H);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
fbTime.Advance(tStep := T#40M);
xRet := fbAlm.Shelve(tDuration := T#1H);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := xRet, Message := 'repeated shelve accepted');
AssertEquals_TIME(Expected := T#1H, Actual := fbAlm.tShelveRemain, Message := 'shelve time restarted');
AssertEquals_UDINT(Expected := 2, Actual := fbAlm.udiSeq, Message := 'repeated shelve is not a transition');

coUnit.TEST_FINISHED();
