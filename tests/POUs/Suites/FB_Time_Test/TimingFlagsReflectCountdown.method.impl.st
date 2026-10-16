coUnit.TEST('Delay_TimingFlags_ReflectCountdown');

fbDelay(xIn := FALSE, tOnDelay := T#1S, tOffDelay := T#1S, itfTime := fbTime);
AssertFalse(Condition := fbDelay.xTimingOn OR fbDelay.xTimingOff, Message := 'idle: no timing');
fbDelay(xIn := TRUE, tOnDelay := T#1S, tOffDelay := T#1S, itfTime := fbTime);
AssertTrue(Condition := fbDelay.xTimingOn AND NOT fbDelay.xTimingOff,
           Message := 'on-delay timing after the rising edge');
fbTime.Advance(tStep := T#1S);
fbDelay(xIn := TRUE, tOnDelay := T#1S, tOffDelay := T#1S, itfTime := fbTime);
AssertFalse(Condition := fbDelay.xTimingOn, Message := 'on-delay finished');
fbDelay(xIn := FALSE, tOnDelay := T#1S, tOffDelay := T#1S, itfTime := fbTime);
AssertTrue(Condition := fbDelay.xTimingOff AND NOT fbDelay.xTimingOn,
           Message := 'off-delay timing after the falling edge');
fbTime.Advance(tStep := T#1S);
fbDelay(xIn := FALSE, tOnDelay := T#1S, tOffDelay := T#1S, itfTime := fbTime);
AssertFalse(Condition := fbDelay.xTimingOff OR fbDelay.xOut, Message := 'off-delay finished, output off');

coUnit.TEST_FINISHED();
