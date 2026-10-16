coUnit.TEST('Runtime_LTime_MonotonicAcrossTaskCycles');

IF uiRtCount < RT_SAMPLES THEN
    altRtStamp[uiRtCount] := fbRtSysTime.Now();
    uiRtCount := uiRtCount + 1;
ELSE
    FOR uiIdx := 1 TO RT_SAMPLES - 1 DO
        xStrict := xStrict AND (altRtStamp[uiIdx] > altRtStamp[uiIdx - 1]);
    END_FOR
    IF xStrict THEN
        ltSpan := altRtStamp[RT_SAMPLES - 1] - altRtStamp[0];
    ELSE
        ltSpan := LTIME#0S;
    END_IF
    AssertTrue(Condition := xStrict, Message := 'LTIME() strictly increases from task cycle to task cycle');
    AssertTrue(Condition := ltSpan >= LTIME#245MS, Message := '49 task cycles of 10 ms last at least 245 ms');
    AssertTrue(Condition := ltSpan <= LTIME#2S450MS, Message := '49 task cycles of 10 ms last at most 2.45 s');
    coUnit.TEST_FINISHED();
END_IF
