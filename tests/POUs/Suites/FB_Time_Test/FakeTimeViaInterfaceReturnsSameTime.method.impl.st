coUnit.TEST('Time_FakeTime_ViaInterface_ReturnsSameTime');

itfTime := fbTime;
fbTime.Advance(tStep := T#3S);
AssertEquals_LTIME(Expected := fbTime.Now(), Actual := itfTime.Now(), Message := 'interface returns the fake time');
AssertEquals_LTIME(Expected := LTIME#3S, Actual := itfTime.Now() - LTIME#1H, Message := 'one step of 3 s from 1 h');

coUnit.TEST_FINISHED();
