coUnit.TEST('Delay_OnDelay_ShortPulse_Ignored');

fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);              // t0: фронт
FOR iStep := 1 TO 15 DO                                                 // вход TRUE до t0 + 1,4 с
    fbTime.Advance(tStep := T#100MS);
    fbDelay(xIn := iStep < 15, tOnDelay := T#2S, itfTime := fbTime);
    xEverOn := xEverOn OR fbDelay.xOut;
END_FOR
FOR iStep := 1 TO 50 DO
    fbTime.Advance(tStep := T#100MS);
    fbDelay(xIn := FALSE, tOnDelay := T#2S, itfTime := fbTime);
    xEverOn := xEverOn OR fbDelay.xOut;
END_FOR
AssertFalse(Condition := xEverOn, Message := 'pulse shorter than the on-delay must be ignored');
AssertFalse(Condition := fbDelay.xTimingOn, Message := 'timing must be cancelled when the input returns');

coUnit.TEST_FINISHED();
