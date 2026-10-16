coUnit.TEST('Delay_OffDelay_ShortGap_Ignored');

fbDelay(xIn := TRUE, tOffDelay := T#3S, itfTime := fbTime);
fbDelay(xIn := FALSE, tOffDelay := T#3S, itfTime := fbTime);            // t0: спад
xEverOff := NOT fbDelay.xOut;
FOR iStep := 1 TO 19 DO                                                 // вход FALSE до t0 + 1,8 с
    fbTime.Advance(tStep := T#100MS);
    fbDelay(xIn := iStep >= 19, tOffDelay := T#3S, itfTime := fbTime);
    xEverOff := xEverOff OR NOT fbDelay.xOut;
END_FOR
FOR iStep := 1 TO 50 DO
    fbTime.Advance(tStep := T#100MS);
    fbDelay(xIn := TRUE, tOffDelay := T#3S, itfTime := fbTime);
    xEverOff := xEverOff OR NOT fbDelay.xOut;
END_FOR
AssertFalse(Condition := xEverOff, Message := 'gap shorter than the off-delay must be ignored');
AssertFalse(Condition := fbDelay.xTimingOff, Message := 'off-delay timing cancelled');

coUnit.TEST_FINISHED();
