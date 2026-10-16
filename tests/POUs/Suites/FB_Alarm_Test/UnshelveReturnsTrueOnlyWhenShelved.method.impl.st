coUnit.TEST('Alarm_Unshelve_ReturnsTrueOnlyWhenShelved');

fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
xRet := fbAlm.Unshelve();
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertFalse(Condition := xRet, Message := 'Unshelve returns FALSE without shelve');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'no effect without shelve');
fbAlm.Shelve(tDuration := T#1H);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
xRet := fbAlm.Unshelve();
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := xRet, Message := 'Unshelve returns TRUE while shelved');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'unshelved with condition -> ActiveUnack');

coUnit.TEST_FINISHED();
