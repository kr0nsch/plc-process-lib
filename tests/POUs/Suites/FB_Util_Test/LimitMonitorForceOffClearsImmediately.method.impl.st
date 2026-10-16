coUnit.TEST('Util_LimitMonitor_ForceOff_ClearsImmediately');

stLimCfg.xEnable := TRUE;
stLimCfg.rSetpoint_eu := 50.0;
stLimCfg.rHyst_eu := 1.0;
stLimCfg.tOffDelay := T#10S;
fbLim(rValue_eu := 60.0, xHighLimit := TRUE, xForceOff := FALSE, stCfg := stLimCfg, itfTime := fbTime);
AssertTrue(Condition := fbLim.xOut, Message := 'flag set without on-delay');
fbLim(rValue_eu := 60.0, xHighLimit := TRUE, xForceOff := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertFalse(Condition := fbLim.xOut, Message := 'xForceOff clears the flag at once despite the off-delay');
AssertFalse(Condition := fbLim.xRaw, Message := 'xForceOff clears the raw flag too');
fbLim(rValue_eu := 60.0, xHighLimit := TRUE, xForceOff := FALSE, stCfg := stLimCfg, itfTime := fbTime);
AssertTrue(Condition := fbLim.xOut, Message := 'flag returns after the force is released');

coUnit.TEST_FINISHED();
