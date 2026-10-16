coUnit.TEST('Util_LimitMonitor_OffDelay_HoldsFlag');

stLimCfg.xEnable := TRUE;
stLimCfg.rSetpoint_eu := 80.0;
stLimCfg.rHyst_eu := 2.0;
stLimCfg.tOffDelay := T#2S;
fbLim(rValue_eu := 85.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertTrue(Condition := fbLim.xOut, Message := 'flag set without on-delay');
fbLim(rValue_eu := 70.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);    // t0
AssertFalse(Condition := fbLim.xRaw, Message := 'raw flag cleared at once');
FOR iStep := 1 TO 19 DO
    fbTime.Advance(tStep := T#100MS);
    fbLim(rValue_eu := 70.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
END_FOR
AssertTrue(Condition := fbLim.xOut, Message := 'flag held at t0 + 1.9 s');
fbTime.Advance(tStep := T#100MS);
fbLim(rValue_eu := 70.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertFalse(Condition := fbLim.xOut, Message := 'flag cleared exactly at t0 + 2.0 s');

coUnit.TEST_FINISHED();
