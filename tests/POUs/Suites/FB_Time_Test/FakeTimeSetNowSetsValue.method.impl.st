coUnit.TEST('Time_FakeTime_SetNow_SetsValue');

fbTime.SetNow(ltValue := LTIME#5D);
AssertEquals_LTIME(Expected := LTIME#5D, Actual := fbTime.Now(), Message := 'SetNow forward');
fbTime.SetNow(ltValue := LTIME#2S);
AssertEquals_LTIME(Expected := LTIME#2S, Actual := fbTime.Now(), Message := 'SetNow backwards');

coUnit.TEST_FINISHED();
