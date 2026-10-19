coUnit.TEST('Alarm_PriorityNone_CancelsShelve');

GVL_Lib.itfAlarmSink := fbSink;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
fbAlm.Shelve(tDuration := T#1H);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // Shelved на 1 ч
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Shelved, Message := 'precondition: Shelved');
udiSeq := fbAlm.udiSeq;
stCfg.ePriority := E_AlarmPriority.None;
fbTime.Advance(tStep := T#1M);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // выключена
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Normal, Message := 'disabled alarm is Normal');
AssertFalse(Condition := fbAlm.xShelved, Message := 'disabling cancels the shelve');
AssertEquals_TIME(Expected := T#0S, Actual := fbAlm.tShelveRemain, Message := 'no shelve time left');
AssertEquals_UDINT(Expected := udiSeq + 1, Actual := fbAlm.udiSeq, Message := 'disabling: one closing transition');
stEv := fbSink.Last;
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.Disabled AND stEv.eOldState = E_AlarmState.Shelved,
           Message := 'closing event Disabled from Shelved');
stCfg.ePriority := E_AlarmPriority.Medium;
fbTime.Advance(tStep := T#1M);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // снова включена
stEv := fbSink.Last;
GVL_Lib.itfAlarmSink := 0;
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack,
           Message := 'enabled with active condition -> ActiveUnack, not Shelved');
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.Activated, Message := 'event reason Activated');
AssertTrue(Condition := stEv.eOldState = E_AlarmState.Normal, Message := 'event old state Normal');

coUnit.TEST_FINISHED();
