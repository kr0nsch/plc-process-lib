coUnit.TEST('Util_LimitMonitor_Reenabled_RestartsOnDelay');

stLimCfg.xEnable := TRUE;
stLimCfg.rSetpoint_eu := 80.0;
stLimCfg.tOnDelay := T#2S;
fbLim(rValue_eu := 90.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);    // t0
FOR iStep := 1 TO 15 DO                                                               // t0 + 1,5 с
    fbTime.Advance(tStep := T#100MS);
    fbLim(rValue_eu := 90.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
END_FOR
stLimCfg.xEnable := FALSE;
fbLim(rValue_eu := 90.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertFalse(Condition := fbLim.xOut OR fbLim.xRaw, Message := 'disabled: flags cleared');
stLimCfg.xEnable := TRUE;
FOR iStep := 1 TO 5 DO                                                                // t0 + 1,6 … 2,0 с
    fbTime.Advance(tStep := T#100MS);
    fbLim(rValue_eu := 90.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
END_FOR
AssertFalse(Condition := fbLim.xOut, Message := 'old timing must not complete after re-enable');
FOR iStep := 1 TO 15 DO                                                               // t0 + 3,5 с
    fbTime.Advance(tStep := T#100MS);
    fbLim(rValue_eu := 90.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
END_FOR
AssertFalse(Condition := fbLim.xOut, Message := 'no flag 1.9 s after re-enable');
fbTime.Advance(tStep := T#100MS);
fbLim(rValue_eu := 90.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);    // t0 + 3,6 с
AssertTrue(Condition := fbLim.xOut, Message := 'flag 2.0 s after re-enable');

coUnit.TEST_FINISHED();
