coUnit.TEST('Util_LimitMonitor_OnDelay_ShortExcursionIgnored');

stLimCfg.xEnable := TRUE;
stLimCfg.rSetpoint_eu := 80.0;
stLimCfg.rHyst_eu := 2.0;
stLimCfg.tOnDelay := T#3S;
fbLim(rValue_eu := 85.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);    // t0
FOR iStep := 1 TO 29 DO                                                               // t0 + 2,9 с
    fbTime.Advance(tStep := T#100MS);
    fbLim(rValue_eu := 85.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
    xEverSet := xEverSet OR fbLim.xOut;
END_FOR
AssertTrue(Condition := fbLim.xRaw, Message := 'raw flag is set before the delay');
fbTime.Advance(tStep := T#100MS);
fbLim(rValue_eu := 70.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);    // t0 + 3,0 с
xEverSet := xEverSet OR fbLim.xOut;
AssertFalse(Condition := xEverSet, Message := 'excursion shorter than the on-delay must be ignored');
fbLim(rValue_eu := 85.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);    // t1
FOR iStep := 1 TO 29 DO
    fbTime.Advance(tStep := T#100MS);
    fbLim(rValue_eu := 85.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
END_FOR
AssertFalse(Condition := fbLim.xOut, Message := 'no flag at t1 + 2.9 s');
fbTime.Advance(tStep := T#100MS);
fbLim(rValue_eu := 85.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);    // t1 + 3,0 с
AssertTrue(Condition := fbLim.xOut, Message := 'flag exactly at t1 + 3.0 s');

coUnit.TEST_FINISHED();
