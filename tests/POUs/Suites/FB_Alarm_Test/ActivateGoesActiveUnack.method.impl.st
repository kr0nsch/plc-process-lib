coUnit.TEST('Alarm_Activate_GoesActiveUnack');

fbAlm(xIn := FALSE, udiId := 101, stCfg := stCfg, itfTime := fbTime);                // t0: условия нет
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Normal, Message := 'Normal without condition');
AssertEquals_UDINT(Expected := 0, Actual := fbAlm.udiSeq, Message := 'no transition without condition');
fbTime.Advance(tStep := T#1S);
fbAlm(xIn := TRUE, udiId := 101, stCfg := stCfg, itfTime := fbTime);                 // t0 + 1 с: условие
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'condition gives ActiveUnack');
AssertTrue(Condition := fbAlm.xActive, Message := 'xActive set');
AssertTrue(Condition := fbAlm.xUnacked, Message := 'xUnacked set');
AssertTrue(Condition := fbAlm.xInList, Message := 'shown in the alarm list');
AssertEquals_UDINT(Expected := 1, Actual := fbAlm.udiSeq, Message := 'one transition');
AssertEquals_LTIME(Expected := fbTime.Now(), Actual := fbAlm.ltLastChange, Message := 'time of the transition');

coUnit.TEST_FINISHED();
