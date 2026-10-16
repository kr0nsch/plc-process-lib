coUnit.TEST('Alarm_ShelveDurationAboveMax_ClippedToMax');

stCfg.tShelveMax := T#1H;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
xRet := fbAlm.Shelve(tDuration := T#2H);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := xRet, Message := 'shelve accepted');
AssertEquals_TIME(Expected := T#1H, Actual := fbAlm.tShelveRemain, Message := '2 h clipped to tShelveMax 1 h');
fbAlm.Unshelve();
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
xRet := fbAlm.Shelve(tDuration := T#30M);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertEquals_TIME(Expected := T#30M, Actual := fbAlm.tShelveRemain, Message := 'shorter duration used as is');

coUnit.TEST_FINISHED();
