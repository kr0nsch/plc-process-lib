coUnit.TEST('Delay_BothDelays_OnThenOffTimed');

fbDelay(xIn := TRUE, tOnDelay := T#1S, tOffDelay := T#2S, itfTime := fbTime);   // t0: фронт
fbTime.Advance(tStep := T#500MS);
fbDelay(xIn := TRUE, tOnDelay := T#1S, tOffDelay := T#2S, itfTime := fbTime);
AssertFalse(Condition := fbDelay.xOut, Message := 'not on at t0 + 0.5 s');
fbTime.Advance(tStep := T#500MS);
fbDelay(xIn := TRUE, tOnDelay := T#1S, tOffDelay := T#2S, itfTime := fbTime);
AssertTrue(Condition := fbDelay.xOut, Message := 'on at t0 + 1.0 s');
fbDelay(xIn := FALSE, tOnDelay := T#1S, tOffDelay := T#2S, itfTime := fbTime);  // t1: спад
fbTime.Advance(tStep := T#1500MS);
fbDelay(xIn := FALSE, tOnDelay := T#1S, tOffDelay := T#2S, itfTime := fbTime);
AssertTrue(Condition := fbDelay.xOut, Message := 'still on at t1 + 1.5 s');
fbTime.Advance(tStep := T#500MS);
fbDelay(xIn := FALSE, tOnDelay := T#1S, tOffDelay := T#2S, itfTime := fbTime);
AssertFalse(Condition := fbDelay.xOut, Message := 'off at t1 + 2.0 s');

coUnit.TEST_FINISHED();
