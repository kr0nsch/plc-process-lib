coUnit.TEST('Device_HookViaThis_DispatchesToMostDerivedOverride');

stCmd.stCommon.xSetAuto := TRUE;
fbExt(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UDINT(Expected := 12, Actual := fbExt.udiHookTrace, Message := 'most derived override, SUPER^ part first');
AssertEquals_UINT(Expected := 1, Actual := fbExt.uiHookCalls, Message := 'FB_TestDevice part once');
AssertEquals_UINT(Expected := 1, Actual := fbExt.uiExtHookCalls, Message := 'FB_TestDeviceExt part once');
stCmd.stCommon.xSetManual := TRUE;
fbExt(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UDINT(Expected := 1212, Actual := fbExt.udiHookTrace, Message := 'same chain on the second change');
AssertEquals_UINT(Expected := 2, Actual := fbExt.uiExtHookCalls, Message := 'FB_TestDeviceExt part twice');

coUnit.TEST_FINISHED();
