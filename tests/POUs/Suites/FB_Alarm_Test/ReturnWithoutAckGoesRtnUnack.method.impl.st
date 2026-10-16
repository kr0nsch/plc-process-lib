coUnit.TEST('Alarm_ReturnWithoutAck_GoesRtnUnack');

fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
fbTime.Advance(tStep := T#5S);
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);                               // условие ушло
AssertTrue(Condition := fbAlm.eState = E_AlarmState.RtnUnack, Message := 'ActiveUnack -> RtnUnack');
AssertFalse(Condition := fbAlm.xActive, Message := 'condition gone');
AssertTrue(Condition := fbAlm.xUnacked, Message := 'still unacknowledged');
AssertTrue(Condition := fbAlm.xInList, Message := 'still shown in the alarm list');
AssertEquals_UDINT(Expected := 2, Actual := fbAlm.udiSeq, Message := 'two transitions');

coUnit.TEST_FINISHED();
