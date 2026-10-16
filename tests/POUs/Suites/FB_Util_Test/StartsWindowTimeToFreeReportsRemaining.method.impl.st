coUnit.TEST('Util_StartsWindow_TimeToFree_ReportsRemaining');

fbWin.Register(ltNow := LTIME#1H);
fbWin.Register(ltNow := LTIME#1H10M);
fbWin.Register(ltNow := LTIME#1H20M);
AssertEquals_LTIME(Expected := LTIME#30M, Actual := fbWin.TimeToFree(ltNow := LTIME#1H30M, uiMax := 3),
                   Message := 'limit 3: the oldest start frees the window in 30 min');
AssertEquals_LTIME(Expected := LTIME#40M, Actual := fbWin.TimeToFree(ltNow := LTIME#1H30M, uiMax := 2),
                   Message := 'limit 2: two oldest starts must leave, 40 min');
AssertEquals_LTIME(Expected := LTIME#0S, Actual := fbWin.TimeToFree(ltNow := LTIME#1H30M, uiMax := 4),
                   Message := 'limit 4 not reached: 0');
AssertEquals_LTIME(Expected := LTIME#0S, Actual := fbWin.TimeToFree(ltNow := LTIME#1H30M, uiMax := 0),
                   Message := 'no limit: 0');
AssertEquals_LTIME(Expected := LTIME#0S, Actual := fbWin.TimeToFree(ltNow := LTIME#2H, uiMax := 3),
                   Message := 'at 2:00 the start of 1:00 has left: 0');

coUnit.TEST_FINISHED();
