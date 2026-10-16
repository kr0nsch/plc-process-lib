coUnit.TEST('Delay_DelayChangedWhileTiming_UsesNewValue');

fbShorter(xIn := TRUE, tOnDelay := T#10S, itfTime := fbTime);         // t0: фронт
fbLonger(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);
FOR iStep := 1 TO 15 DO                                                 // t0 + 1,5 с
    fbTime.Advance(tStep := T#100MS);
    fbShorter(xIn := TRUE, tOnDelay := T#10S, itfTime := fbTime);
    fbLonger(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);
END_FOR
fbShorter(xIn := TRUE, tOnDelay := T#1S, itfTime := fbTime);
AssertTrue(Condition := fbShorter.xOut, Message := 'delay reduced below the elapsed time: output at once');
FOR iStep := 1 TO 5 DO                                                  // t0 + 2,0 с
    fbTime.Advance(tStep := T#100MS);
    fbLonger(xIn := TRUE, tOnDelay := T#5S, itfTime := fbTime);
END_FOR
AssertFalse(Condition := fbLonger.xOut, Message := 'delay increased: no output at the old 2 s');
FOR iStep := 1 TO 29 DO                                                 // t0 + 4,9 с
    fbTime.Advance(tStep := T#100MS);
    fbLonger(xIn := TRUE, tOnDelay := T#5S, itfTime := fbTime);
END_FOR
AssertFalse(Condition := fbLonger.xOut, Message := 'no output at t0 + 4.9 s');
fbTime.Advance(tStep := T#100MS);
fbLonger(xIn := TRUE, tOnDelay := T#5S, itfTime := fbTime);             // t0 + 5,0 с
AssertTrue(Condition := fbLonger.xOut, Message := 'output at the new delay 5 s');

coUnit.TEST_FINISHED();
