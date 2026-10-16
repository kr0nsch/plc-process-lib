coUnit.TEST('Device_Failure_SafeStateResetRules');

stCmd.xStart := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.xOutput, Message := 'running in Manual');
fbDev(xFaultCause := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := fbDev.xOutput, Message := 'output off on failure');
AssertTrue(Condition := fbDev.Fault, Message := 'Fault');
AssertTrue(Condition := fbDev.Status = E_Ne107Status.Failure, Message := 'NE 107 Failure');
AssertEquals_WORD(Expected := 16#0001, Actual := fbDev.stSts.stCommon.wFault, Message := 'wFault bit');
AssertFalse(Condition := fbDev.Available, Message := 'not available');
stCmd.stCommon.xReset := TRUE;
fbDev(xFaultCause := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.RejectedFault,
           Message := 'Reset with active cause rejected');
AssertTrue(Condition := fbDev.Fault, Message := 'still faulted');
fbDev(xFaultCause := FALSE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Fault, Message := 'fault latched after the cause is gone');
xRet := fbDev.Reset();
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := xRet, Message := 'Reset() request accepted');
AssertFalse(Condition := fbDev.Fault, Message := 'fault cleared by Reset()');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'Reset accepted');
AssertFalse(Condition := fbDev.xOutput, Message := 'no automatic restart after Reset');

coUnit.TEST_FINISHED();
