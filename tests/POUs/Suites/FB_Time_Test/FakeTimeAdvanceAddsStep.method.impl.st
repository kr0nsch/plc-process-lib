coUnit.TEST('Time_FakeTime_Advance_AddsStep');

ltMark := fbTime.Now();
fbTime.Advance(tStep := T#250MS);
fbTime.Advance(tStep := T#250MS);
AssertEquals_LTIME(Expected := LTIME#500MS, Actual := fbTime.Now() - ltMark, Message := 'two steps of 250 ms');
ltMark := fbTime.Now();
fbTime.Advance(tStep := T#49D);
AssertEquals_LTIME(Expected := LTIME#49D, Actual := fbTime.Now() - ltMark, Message := 'TIME step of 49 days');

coUnit.TEST_FINISHED();
