coUnit.TEST('Util_StartsWindow_Clear_Empties');

fbWin.Register(ltNow := LTIME#1H);
fbWin.Register(ltNow := LTIME#1H1M);
fbWin.Register(ltNow := LTIME#1H2M);
AssertEquals_UINT(Expected := 3, Actual := fbWin.Count(ltNow := LTIME#1H3M), Message := 'three starts before Clear');
fbWin.Clear();
AssertEquals_UINT(Expected := 0, Actual := fbWin.Count(ltNow := LTIME#1H3M), Message := 'no starts after Clear');
AssertEquals_LTIME(Expected := LTIME#0S, Actual := fbWin.TimeToFree(ltNow := LTIME#1H3M, uiMax := 1),
                   Message := 'nothing to free after Clear');

coUnit.TEST_FINISHED();
