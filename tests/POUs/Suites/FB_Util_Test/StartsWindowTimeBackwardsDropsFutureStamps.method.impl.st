coUnit.TEST('Util_StartsWindow_TimeBackwards_DropsFutureStamps');

fbWin.Register(ltNow := LTIME#2H);
fbWin.Register(ltNow := LTIME#2H10M);
AssertEquals_UINT(Expected := 0, Actual := fbWin.Count(ltNow := LTIME#1H30M),
                  Message := 'future starts are not counted');
AssertEquals_UINT(Expected := 0, Actual := fbWin.Count(ltNow := LTIME#2H20M), Message := 'future starts were removed');
fbWin.Register(ltNow := LTIME#3H);
fbWin.Register(ltNow := LTIME#2H50M);
AssertEquals_UINT(Expected := 1, Actual := fbWin.Count(ltNow := LTIME#2H55M),
                  Message := 'Register drops stamps newer than the new one');

coUnit.TEST_FINISHED();
