coUnit.TEST('Delay_FirstCallWithInputTrue_StartsOnDelay');

fbDelay(xIn := TRUE, tOnDelay := T#1S, itfTime := fbTime);
AssertFalse(Condition := fbDelay.xOut, Message := 'first call must start the on-delay, not complete it');
AssertEquals_TIME(Expected := T#1S, Actual := fbDelay.tRemaining, Message := 'full delay left after the first call');
fbTime.Advance(tStep := T#1S);
fbDelay(xIn := TRUE, tOnDelay := T#1S, itfTime := fbTime);
AssertTrue(Condition := fbDelay.xOut, Message := 'output on after the delay');

coUnit.TEST_FINISHED();
