coUnit.TEST('Delay_Remaining_ReportsTimeLeft');

fbDelay(xIn := TRUE, tOnDelay := T#5S, tOffDelay := T#4S, itfTime := fbTime);
AssertEquals_TIME(Expected := T#5S, Actual := fbDelay.tRemaining, Message := 'full on-delay after the edge');
fbTime.Advance(tStep := T#1500MS);
fbDelay(xIn := TRUE, tOnDelay := T#5S, tOffDelay := T#4S, itfTime := fbTime);
AssertEquals_TIME(Expected := T#3S500MS, Actual := fbDelay.tRemaining, Message := 'on-delay left after 1.5 s');
fbTime.Advance(tStep := T#3500MS);
fbDelay(xIn := TRUE, tOnDelay := T#5S, tOffDelay := T#4S, itfTime := fbTime);
AssertTrue(Condition := fbDelay.xOut, Message := 'output on after 5 s');
AssertEquals_TIME(Expected := T#0S, Actual := fbDelay.tRemaining, Message := 'nothing to time: T#0S');
fbDelay(xIn := FALSE, tOnDelay := T#5S, tOffDelay := T#4S, itfTime := fbTime);
fbTime.Advance(tStep := T#1S);
fbDelay(xIn := FALSE, tOnDelay := T#5S, tOffDelay := T#4S, itfTime := fbTime);
AssertEquals_TIME(Expected := T#3S, Actual := fbDelay.tRemaining, Message := 'off-delay left after 1 s');

coUnit.TEST_FINISHED();
