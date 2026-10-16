coUnit.TEST('Alarm_AckAfterReturn_GoesNormal');

fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);                               // RtnUnack
xRet := fbAlm.Ack();
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := xRet, Message := 'Ack returns TRUE in RtnUnack');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Normal, Message := 'RtnUnack -> Normal');
AssertFalse(Condition := fbAlm.xInList, Message := 'removed from the alarm list');
AssertFalse(Condition := fbAlm.xUnacked, Message := 'acknowledged');
AssertEquals_UDINT(Expected := 3, Actual := fbAlm.udiSeq, Message := 'three transitions');

coUnit.TEST_FINISHED();
