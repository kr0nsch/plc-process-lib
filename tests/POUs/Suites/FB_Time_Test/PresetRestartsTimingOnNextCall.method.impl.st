coUnit.TEST('Delay_Preset_RestartsTimingOnNextCall');

fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);              // t0: фронт
FOR iStep := 1 TO 15 DO                                                 // t0 + 1,5 с
    fbTime.Advance(tStep := T#100MS);
    fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);
END_FOR
fbDelay.Preset(xValue := FALSE);
FOR iStep := 1 TO 5 DO                                                  // t0 + 1,6 с — новая отметка
    fbTime.Advance(tStep := T#100MS);                                   // ... t0 + 2,0 с
    fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);
END_FOR
AssertFalse(Condition := fbDelay.xOut, Message := 'old timing must not complete after Preset');
FOR iStep := 1 TO 15 DO                                                 // t0 + 3,5 с
    fbTime.Advance(tStep := T#100MS);
    fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);
END_FOR
AssertFalse(Condition := fbDelay.xOut, Message := 'no output 1.9 s after the restart');
fbTime.Advance(tStep := T#100MS);
fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);              // t0 + 3,6 с
AssertTrue(Condition := fbDelay.xOut, Message := 'output 2.0 s after the restart');

coUnit.TEST_FINISHED();
