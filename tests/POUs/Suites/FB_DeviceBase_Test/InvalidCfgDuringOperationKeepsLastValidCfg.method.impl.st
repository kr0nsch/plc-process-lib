coUnit.TEST('Device_InvalidCfgDuringOperation_KeepsLastValidCfg');

stCmd.stCommon.xSetAuto := TRUE;
fbDev(xAutoRun := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.xOutput AND fbDev.Available, Message := 'running and available in Auto');
AssertEquals_REAL(Expected := 20.0, Actual := fbDev.rOut_eu, Delta := 0.0, Message := 'value from valid cfg');
stCfg.rGain := -1.0;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 16#0001, Actual := fbDev.stSts.stCommon.wCfgErr, Message := 'wCfgErr bit 0');
AssertTrue(Condition := fbDev.Status = E_Ne107Status.CheckFunction, Message := 'NE 107 CheckFunction');
AssertEquals_REAL(Expected := 20.0, Actual := fbDev.rOut_eu, Delta := 0.0, Message := 'logic uses the last valid cfg');
AssertTrue(Condition := fbDev.xOutput, Message := 'mechanism keeps running');
AssertTrue(Condition := fbDev.Available, Message := 'availability unchanged');
stCfg.rGain := 3.0;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wCfgErr, Message := 'cfg valid again');
AssertTrue(Condition := fbDev.Status = E_Ne107Status.Good, Message := 'NE 107 Good');
AssertEquals_REAL(Expected := 30.0, Actual := fbDev.rOut_eu, Delta := 0.0, Message := 'new valid cfg accepted');

coUnit.TEST_FINISHED();
