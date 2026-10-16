coUnit.TEST('Util_StartsWindow_CountsOnlyLastHour');

fbWin.Register(ltNow := LTIME#1H);
fbWin.Register(ltNow := LTIME#1H20M);
fbWin.Register(ltNow := LTIME#1H40M);
AssertEquals_UINT(Expected := 3, Actual := fbWin.Count(ltNow := LTIME#1H59M59S), Message := 'three starts at 1:59:59');
AssertEquals_UINT(Expected := 2, Actual := fbWin.Count(ltNow := LTIME#2H),
                  Message := 'start of 1:00 left the window at 2:00');
AssertEquals_UINT(Expected := 1, Actual := fbWin.Count(ltNow := LTIME#2H30M), Message := 'one start at 2:30');
AssertEquals_UINT(Expected := 0, Actual := fbWin.Count(ltNow := LTIME#2H40M), Message := 'no starts at 2:40');

coUnit.TEST_FINISHED();
