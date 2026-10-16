coUnit.TEST('Alarm_InterfaceProperties_MatchOutputs');

stCfg.ePriority := E_AlarmPriority.Low;
itfAlm := fbAlm;
fbAlm(xIn := TRUE, udiId := 125, stCfg := stCfg, itfTime := fbTime);
AssertEquals_UDINT(Expected := 125, Actual := itfAlm.Id, Message := 'Id');
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'State');
AssertTrue(Condition := itfAlm.AlarmPriority = E_AlarmPriority.Low, Message := 'AlarmPriority');
AssertTrue(Condition := itfAlm.Active, Message := 'Active');
AssertTrue(Condition := itfAlm.Unacked, Message := 'Unacked');
AssertEquals_UDINT(Expected := 1, Actual := itfAlm.Seq, Message := 'Seq');
itfAlm.Ack();
fbAlm(xIn := TRUE, udiId := 125, stCfg := stCfg, itfTime := fbTime);
AssertFalse(Condition := itfAlm.Unacked, Message := 'Ack through the interface');

coUnit.TEST_FINISHED();
