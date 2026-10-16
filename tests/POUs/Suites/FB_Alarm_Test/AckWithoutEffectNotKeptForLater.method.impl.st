coUnit.TEST('Alarm_AckWithoutEffect_NotKeptForLater');

fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);                               // Normal
fbAlm.Ack();
fbAlm(xIn := FALSE, stCfg := stCfg, itfTime := fbTime);                               // Ack без эффекта
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // появление
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack,
           Message := 'Ack given in Normal does not acknowledge the next activation');

fbAlm.Shelve(tDuration := T#1M);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // t0: Shelved
fbAlm.Ack();
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // Ack в Shelved
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Shelved, Message := 'Ack in Shelved has no effect');
fbTime.Advance(tStep := T#1M);
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // срок истёк
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack,
           Message := 'Ack given while Shelved does not acknowledge the reannunciation');
AssertTrue(Condition := fbAlm.xUnacked, Message := 'reannunciated alarm is unacknowledged');

coUnit.TEST_FINISHED();
