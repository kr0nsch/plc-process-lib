coUnit.TEST('Device_OnModeChangedHook_CalledInDerived');

fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Manual
AssertEquals_UINT(Expected := 0, Actual := fbDev.uiHookCalls, Message := 'no mode change, no hook');
stCmd.stCommon.xSetAuto := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := 1, Actual := fbDev.uiHookCalls, Message := 'override called via THIS^ from ProcessMode');
AssertTrue(Condition := fbDev.eHookOld = E_DeviceMode.Manual, Message := 'eOld = Manual');
AssertTrue(Condition := fbDev.eHookNew = E_DeviceMode.Auto, Message := 'eNew = Auto');
AssertEquals_UDINT(Expected := 1, Actual := fbDev.udiHookTrace, Message := 'override of FB_TestDevice ran once');
stCmd.xStop := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := 2, Actual := fbDev.uiHookCalls,
                  Message := 'override called via THIS^ from SwitchRemoteMode');
AssertTrue(Condition := fbDev.eHookOld = E_DeviceMode.Auto, Message := 'eOld = Auto');
AssertTrue(Condition := fbDev.eHookNew = E_DeviceMode.Manual, Message := 'eNew = Manual');

coUnit.TEST_FINISHED();
