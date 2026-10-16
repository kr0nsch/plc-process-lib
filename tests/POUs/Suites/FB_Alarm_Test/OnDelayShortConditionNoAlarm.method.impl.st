coUnit.TEST('Alarm_OnDelay_ShortCondition_NoAlarm');

stCfg.tOnDelay := T#3S;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // t0: условие
FOR iStep := 1 TO 29 DO                                                               // до t0 + 2,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
    xEver := xEver OR fbAlm.eState <> E_AlarmState.Normal;
END_FOR
FOR iStep := 1 TO 20 DO                                                               // условие ушло
    fbTime.Advance(tStep := T#100MS);
    fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);
    xEver := xEver OR fbAlm.eState <> E_AlarmState.Normal;
END_FOR
AssertFalse(Condition := xEver, Message := 'condition of 2.9 s with tOnDelay 3 s raises no alarm');
AssertEquals_UDINT(Expected := 0, Actual := fbAlm.udiSeq, Message := 'no transitions');

fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // t1: условие
FOR iStep := 1 TO 29 DO
    fbTime.Advance(tStep := T#100MS);
    fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
END_FOR
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Normal, Message := 'no alarm at t1 + 2.9 s');
fbTime.Advance(tStep := T#100MS);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // t1 + 3,0 с
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'alarm exactly at t1 + 3.0 s');

coUnit.TEST_FINISHED();
