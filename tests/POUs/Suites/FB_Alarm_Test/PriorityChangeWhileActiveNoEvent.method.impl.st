coUnit.TEST('Alarm_PriorityChangeWhileActive_NoEvent');

itfAlm := fbAlm;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
stCfg.ePriority := E_AlarmPriority.High;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := itfAlm.AlarmPriority = E_AlarmPriority.High, Message := 'new priority at once');
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'state unchanged');
AssertEquals_UDINT(Expected := 1, Actual := fbAlm.udiSeq, Message := 'priority change is not a transition');

coUnit.TEST_FINISHED();
