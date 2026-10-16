coUnit.TEST('Alarm_SeqIncrementsOnEachTransition');

itfAlm := fbAlm;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // 1 Activated
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // без перехода
fbAlm.Ack();
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // 2 Acked
fbAlm.Shelve(tDuration := T#1H);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // 3 Shelved
fbAlm.Unshelve();
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // 4 Unshelved -> ActiveUnack
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);                               // 5 Cleared -> RtnUnack
fbAlm.Ack();
fbTime.Advance(tStep := T#3S);
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);                               // 6 Acked -> Normal
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);                               // без перехода
AssertEquals_UDINT(Expected := 6, Actual := fbAlm.udiSeq, Message := 'six transitions');
AssertEquals_UDINT(Expected := 6, Actual := itfAlm.Seq, Message := 'Seq property equals udiSeq');
AssertEquals_LTIME(Expected := fbTime.Now(), Actual := fbAlm.ltLastChange, Message := 'time of the last transition');

coUnit.TEST_FINISHED();
