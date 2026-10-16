coUnit.TEST('Device_ResolveTimeBeforeBeginCycle_NestedDelayDeterministic');

stCfg.tRunDelay := T#2S;
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbDev(xAutoRun := FALSE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);   // первый
fbTime.Advance(tStep := T#1S);
fbDev(xAutoRun := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);    // t1
FOR iStep := 1 TO 19 DO
    fbTime.Advance(tStep := T#100MS);
    fbDev(xAutoRun := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertFalse(Condition := fbDev.xOutput, Message := 'no output at t1 + 1.9 s');
fbTime.Advance(tStep := T#100MS);
fbDev(xAutoRun := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);    // t1 + 2,0 с
AssertTrue(Condition := fbDev.xOutput, Message := 'output exactly at t1 + 2.0 s');

coUnit.TEST_FINISHED();
