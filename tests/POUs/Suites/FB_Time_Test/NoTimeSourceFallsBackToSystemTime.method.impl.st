coUnit.TEST('Delay_NoTimeSource_FallsBackToSystemTime');

fbDelay(xIn := TRUE, tOnDelay := T#1H);
AssertFalse(Condition := fbDelay.xOut, Message := 'one hour of system time cannot pass during the test');
AssertTrue(Condition := fbDelay.xTimingOn, Message := 'on-delay must be timing on the system time');
AssertTrue(Condition := fbDelay.tRemaining > T#59M AND fbDelay.tRemaining <= T#1H,
           Message := 'remaining time must be close to one hour');
fbZero(xIn := TRUE);
AssertTrue(Condition := fbZero.xOut, Message := 'zero delay must pass through with the system time');

coUnit.TEST_FINISHED();
