coUnit.TEST('Alarm_AckWhileActive_GoesActiveAck');

fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
xRet := fbAlm.Ack();
AssertTrue(Condition := xRet, Message := 'Ack returns TRUE while the alarm is unacknowledged');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack,
           Message := 'Ack is a request: no change before the body call');
fbTime.Advance(tStep := T#100MS);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveAck, Message := 'ActiveUnack -> ActiveAck');
AssertFalse(Condition := fbAlm.xUnacked, Message := 'acknowledged');
AssertTrue(Condition := fbAlm.xInList, Message := 'still shown in the alarm list');
AssertTrue(Condition := fbAlm.xActive, Message := 'condition still active');
AssertEquals_UDINT(Expected := 2, Actual := fbAlm.udiSeq, Message := 'two transitions');

coUnit.TEST_FINISHED();
