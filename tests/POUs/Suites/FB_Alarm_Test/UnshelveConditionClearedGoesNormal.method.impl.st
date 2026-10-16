coUnit.TEST('Alarm_Unshelve_ConditionCleared_GoesNormal');

GVL_Lib.itfAlarmSink := fbSink;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
fbAlm.Shelve(tDuration := T#1H);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // Shelved
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);                               // условие ушло
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Shelved, Message := 'stays shelved when the condition clears');
AssertFalse(Condition := fbAlm.xActive, Message := 'xActive follows the condition');
xRet := fbAlm.Unshelve();
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);
GVL_Lib.itfAlarmSink := 0;
AssertTrue(Condition := xRet, Message := 'Unshelve returns TRUE while shelved');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Normal, Message := 'unshelved without condition -> Normal');
stEv := fbSink.Last;
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.Unshelved, Message := 'event reason Unshelved');
AssertTrue(Condition := stEv.eNewState = E_AlarmState.Normal, Message := 'event new state Normal');

coUnit.TEST_FINISHED();
