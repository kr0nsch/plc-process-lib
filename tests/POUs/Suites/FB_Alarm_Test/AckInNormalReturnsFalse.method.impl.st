coUnit.TEST('Alarm_AckInNormal_ReturnsFalse');

fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);
xRet := fbAlm.Ack();
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);
AssertFalse(Condition := xRet, Message := 'Ack in Normal returns FALSE');
AssertEquals_UDINT(Expected := 0, Actual := fbAlm.udiSeq, Message := 'no transition in Normal');
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
fbAlm.Ack();
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveAck
xRet := fbAlm.Ack();
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertFalse(Condition := xRet, Message := 'Ack in ActiveAck returns FALSE');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveAck, Message := 'stays ActiveAck');
AssertEquals_UDINT(Expected := 2, Actual := fbAlm.udiSeq, Message := 'no extra transition');

coUnit.TEST_FINISHED();
