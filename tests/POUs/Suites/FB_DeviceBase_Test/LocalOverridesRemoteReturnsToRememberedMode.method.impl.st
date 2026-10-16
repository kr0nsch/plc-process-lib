coUnit.TEST('Device_LocalOverridesRemote_ReturnsToRememberedMode');

stCmd.stCommon.xSetAuto := TRUE;
fbDev(xAutoRun := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.xOutput, Message := 'running in Auto');
fbDev(xLocal := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Local, Message := 'Local overrides Auto');
AssertFalse(Condition := fbDev.xOutput, Message := 'outputs off in Local');
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Auto, Message := 'remembered remote mode kept');
AssertEquals_WORD(Expected := GVL_Const.DEV_STS_MODE_LOCAL, Actual := fbDev.stSts.stCommon.wStatus AND 16#0F00,
                  Message := 'mode bit Local only');
fbDev(xLocal := FALSE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Auto, Message := 'back to the remembered Auto');
AssertTrue(Condition := fbDev.xOutput, Message := 'runs again on the automatic request');
AssertEquals_UINT(Expected := 3, Actual := fbDev.uiHookCalls, Message := 'hook on each mode change');

coUnit.TEST_FINISHED();
