coUnit.TEST('Delay_OffDelay_HoldsOutputForDelay');

fbDelay(xIn := TRUE, tOnDelay := T#0S, tOffDelay := T#3S, itfTime := fbTime);
AssertTrue(Condition := fbDelay.xOut, Message := 'zero on-delay: output on at once');
fbDelay(xIn := FALSE, tOnDelay := T#0S, tOffDelay := T#3S, itfTime := fbTime);   // t0: спад
FOR iStep := 1 TO 29 DO
    fbTime.Advance(tStep := T#100MS);
    fbDelay(xIn := FALSE, tOnDelay := T#0S, tOffDelay := T#3S, itfTime := fbTime);
END_FOR
AssertTrue(Condition := fbDelay.xOut, Message := 'output held at t0 + 2.9 s');
AssertTrue(Condition := fbDelay.xTimingOff, Message := 'off-delay timing at t0 + 2.9 s');
fbTime.Advance(tStep := T#100MS);
fbDelay(xIn := FALSE, tOnDelay := T#0S, tOffDelay := T#3S, itfTime := fbTime);   // t0 + 3,0 с
AssertFalse(Condition := fbDelay.xOut, Message := 'output off exactly at t0 + 3.0 s');

coUnit.TEST_FINISHED();
