coUnit.TEST('Time_FakeTime_AdvanceL_SubMsAndLongSteps');

ltMark := fbTime.Now();
FOR iStep := 1 TO 4 DO
    fbTime.AdvanceL(ltStep := LTIME#250US);
END_FOR
AssertEquals_LTIME(Expected := LTIME#1MS, Actual := fbTime.Now() - ltMark, Message := 'four steps of 250 us');
ltMark := fbTime.Now();
fbTime.AdvanceL(ltStep := LTIME#60D);
AssertEquals_LTIME(Expected := LTIME#60D, Actual := fbTime.Now() - ltMark, Message := 'LTIME step of 60 days');

coUnit.TEST_FINISHED();
