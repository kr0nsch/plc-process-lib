coUnit.TEST('Time_FakeTime_StartsAtOneHour');

AssertEquals_LTIME(Expected := LTIME#1H, Actual := fbTime.Now(),
                   Message := 'fake time must start at 1 h, not at 0');

coUnit.TEST_FINISHED();
