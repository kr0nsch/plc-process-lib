coUnit.TEST('Util_StartsWindow_RingFull_OverwritesOldest');

FOR iStep := 0 TO 30 DO
    fbWin.Register(ltNow := ltStart);
    ltStart := ltStart + LTIME#1M;
END_FOR
AssertEquals_UINT(Expected := 30, Actual := fbWin.Count(ltNow := LTIME#1H30M), Message := 'ring keeps 30 starts');
AssertEquals_LTIME(Expected := LTIME#31M, Actual := fbWin.TimeToFree(ltNow := LTIME#1H30M, uiMax := 30),
                   Message := 'the start of 1:00 was overwritten, the oldest kept is 1:01');

coUnit.TEST_FINISHED();
