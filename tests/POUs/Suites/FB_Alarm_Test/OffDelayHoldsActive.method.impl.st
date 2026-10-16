coUnit.TEST('Alarm_OffDelay_HoldsActive');

stCfg.tOffDelay := T#2S;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack сразу
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'no on-delay: active at once');
fbTime.Advance(tStep := T#1S);
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);                               // t1: условие ушло
FOR iStep := 1 TO 19 DO                                                               // до t1 + 1,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);
END_FOR
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'still active at t1 + 1.9 s');
AssertTrue(Condition := fbAlm.xActive, Message := 'xActive held by the off-delay');
fbTime.Advance(tStep := T#100MS);
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);                               // t1 + 2,0 с
AssertTrue(Condition := fbAlm.eState = E_AlarmState.RtnUnack, Message := 'RtnUnack exactly at t1 + 2.0 s');

coUnit.TEST_FINISHED();
