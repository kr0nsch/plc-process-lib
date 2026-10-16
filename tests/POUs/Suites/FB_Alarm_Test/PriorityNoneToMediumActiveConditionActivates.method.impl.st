coUnit.TEST('Alarm_PriorityNoneToMedium_ActiveCondition_Activates');

stCfg.ePriority := E_AlarmPriority.None;
FOR iStep := 1 TO 5 DO
    fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
    fbTime.Advance(tStep := T#1S);
END_FOR
stCfg.ePriority := E_AlarmPriority.Medium;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack,
           Message := 'enabled with active condition -> Activated');
AssertEquals_UDINT(Expected := 1, Actual := fbAlm.udiSeq, Message := 'one transition');

stCfg.ePriority := E_AlarmPriority.None;
stCfg.tOnDelay := T#1S;
FOR iStep := 1 TO 5 DO
    fbAlm2(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
    fbTime.Advance(tStep := T#1S);
END_FOR
stCfg.ePriority := E_AlarmPriority.Medium;
fbAlm2(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                               // t1: включена
AssertTrue(Condition := fbAlm2.eState = E_AlarmState.Normal, Message := 'on-delay starts at enabling');
fbTime.Advance(tStep := T#1S);
fbAlm2(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                               // t1 + 1 с
AssertTrue(Condition := fbAlm2.eState = E_AlarmState.ActiveUnack, Message := 'activated 1 s after enabling');

coUnit.TEST_FINISHED();
