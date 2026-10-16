coUnit.TEST('Delay_TimeGoesBackwards_RestartsTiming');

fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);              // t0 = 1 ч
FOR iStep := 1 TO 15 DO                                                 // t0 + 1,5 с
    fbTime.Advance(tStep := T#100MS);
    fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);
END_FOR
fbTime.SetNow(ltValue := LTIME#59M50S);                                 // назад на 11,5 с
fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);
AssertFalse(Condition := fbDelay.xOut, Message := 'time going backwards must not switch the output');
AssertEquals_TIME(Expected := T#2S, Actual := fbDelay.tRemaining,
                  Message := 'timing restarts with the full delay, no unsigned overflow');
FOR iStep := 1 TO 19 DO
    fbTime.Advance(tStep := T#100MS);
    fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);
END_FOR
AssertFalse(Condition := fbDelay.xOut, Message := 'no output 1.9 s after the restart');
fbTime.Advance(tStep := T#100MS);
fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);
AssertTrue(Condition := fbDelay.xOut, Message := 'output 2.0 s after the restart');

coUnit.TEST_FINISHED();
