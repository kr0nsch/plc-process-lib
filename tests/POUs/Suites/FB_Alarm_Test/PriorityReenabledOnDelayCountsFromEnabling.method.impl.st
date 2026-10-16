coUnit.TEST('Alarm_PriorityReenabled_OnDelayCountsFromEnabling');

stCfg.tOnDelay := T#2S;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
fbTime.Advance(tStep := T#2S);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack через 2 с
fbAlm.Ack();
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveAck
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveAck, Message := 'precondition: ActiveAck');
stCfg.ePriority := E_AlarmPriority.None;
FOR iStep := 1 TO 5 DO
    fbTime.Advance(tStep := T#1S);
    fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                            // выключена, условие есть
END_FOR
stCfg.ePriority := E_AlarmPriority.Medium;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // t1: включена
FOR iStep := 1 TO 19 DO
    fbTime.Advance(tStep := T#100MS);
    fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
END_FOR
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Normal, Message := 'Normal until t1 + 1.9 s');
AssertFalse(Condition := fbAlm.xActive, Message := 'condition not active before the on-delay');
fbTime.Advance(tStep := T#100MS);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // t1 + 2,0 с
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'ActiveUnack exactly at t1 + 2 s');

coUnit.TEST_FINISHED();
