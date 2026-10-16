coUnit.TEST('Util_LimitMonitor_Disabled_NeverSets');

stLimCfg.xEnable := FALSE;
stLimCfg.rSetpoint_eu := 50.0;
FOR iStep := 1 TO 100 DO
    fbTime.Advance(tStep := T#100MS);
    fbLim(rValue_eu := 90.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
    xEverSet := xEverSet OR fbLim.xOut OR fbLim.xRaw;
END_FOR
AssertFalse(Condition := xEverSet, Message := 'disabled limit must never set the flag');

coUnit.TEST_FINISHED();
