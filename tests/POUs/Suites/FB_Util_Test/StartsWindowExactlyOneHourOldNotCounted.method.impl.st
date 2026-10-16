coUnit.TEST('Util_StartsWindow_ExactlyOneHourOld_NotCounted');

fbWin.Register(ltNow := LTIME#1H);
AssertEquals_UINT(Expected := 1, Actual := fbWin.Count(ltNow := LTIME#1H59M59S999MS),
                  Message := 'start counted 1 ms before one hour');
AssertEquals_UINT(Expected := 0, Actual := fbWin.Count(ltNow := LTIME#2H),
                  Message := 'start exactly one hour old is out of the window');

coUnit.TEST_FINISHED();
