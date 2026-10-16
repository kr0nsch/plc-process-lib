coUnit.TEST('Device_OosEntry_ClearsLatchedFaults');

stCmd.xStart := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Manual, работает
fbDev(xFaultCause := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbDev(xFaultCause := FALSE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Fault, Message := 'fault latched without Reset');
stCmd.stCommon.xSetOos := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.OutOfService, Message := 'out of service');
AssertFalse(Condition := fbDev.Fault, Message := 'latched fault cleared on entry to OutOfService');
AssertTrue(Condition := fbDev.Status = E_Ne107Status.CheckFunction, Message := 'NE 107 CheckFunction in OutOfService');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wFault, Message := 'no fault bits');
stCmd.stCommon.xSetManual := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Status = E_Ne107Status.Good, Message := 'Good after leaving OutOfService');
AssertFalse(Condition := fbDev.xOutput, Message := 'no restart without a new start command');

coUnit.TEST_FINISHED();
