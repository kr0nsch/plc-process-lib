coUnit.TEST('DigitalInput_ChannelFault_HoldLast');

stCfg.tOffDelay := T#1S;
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
FOR iStep := 1 TO 5 DO   // отказ канала 0,5 с
    fbTime.Advance(tStep := T#100MS);
    fbDi(itfTime := fbTime, xIn := FALSE, xChannelFault := TRUE, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbDi.xValue, Message := 'value before the fault held');
AssertFalse(Condition := fbDi.xValid, Message := 'invalid during fault');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, xChannelFault := FALSE, stCmd := stCmd, stCfg := stCfg);   // tr: канал исправен
AssertTrue(Condition := fbDi.xValue, Message := 'off-delay restarts at recovery');
AssertTrue(Condition := fbDi.xValid, Message := 'valid after recovery');
FOR iStep := 1 TO 9 DO   // tr + 0,9 с
    fbTime.Advance(tStep := T#100MS);
    fbDi(itfTime := fbTime, xIn := FALSE, xChannelFault := FALSE, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbDi.xValue, Message := 'held until tr + 1.0 s');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, xChannelFault := FALSE, stCmd := stCmd, stCfg := stCfg);   // tr + 1,0 с
AssertFalse(Condition := fbDi.xValue, Message := 'off after off-delay from recovery');

coUnit.TEST_FINISHED();
