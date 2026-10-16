coUnit.TEST('Alarm_NoTimeSource_FallsBackToSystemTime');

fbAlm(xIn := TRUE, stCfg := stCfg);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack, Message := 'activated with system time');
AssertTrue(Condition := fbAlm.ltLastChange > LTIME#0S, Message := 'system time stamp above zero');
stCfg.tOnDelay := T#1H;
FOR iStep := 1 TO 100 DO
    fbAlm2(xIn := TRUE, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAlm2.eState = E_AlarmState.Normal, Message := 'on-delay of 1 h does not expire');

coUnit.TEST_FINISHED();
