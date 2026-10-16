coUnit.TEST('Delay_ZeroDelays_PassThroughSameCall');

fbDelay(xIn := TRUE, tOnDelay := T#0S, tOffDelay := T#0S, itfTime := fbTime);
AssertTrue(Condition := fbDelay.xOut, Message := 'rising edge must pass in the same call');
AssertFalse(Condition := fbDelay.xTimingOn, Message := 'no on-delay timing with T#0S');
fbDelay(xIn := FALSE, tOnDelay := T#0S, tOffDelay := T#0S, itfTime := fbTime);
AssertFalse(Condition := fbDelay.xOut, Message := 'falling edge must pass in the same call');
AssertFalse(Condition := fbDelay.xTimingOff, Message := 'no off-delay timing with T#0S');

coUnit.TEST_FINISHED();
