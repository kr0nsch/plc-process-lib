coUnit.TEST('Delay_OnDelay_OutputExactlyAtDelay');

fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);              // t0: фронт
FOR iStep := 1 TO 19 DO
    fbTime.Advance(tStep := T#100MS);
    fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);
END_FOR
AssertFalse(Condition := fbDelay.xOut, Message := 'no output at t0 + 1.9 s');
fbTime.Advance(tStep := T#100MS);
fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);              // t0 + 2,0 с
AssertTrue(Condition := fbDelay.xOut, Message := 'output exactly at t0 + 2.0 s');

coUnit.TEST_FINISHED();
