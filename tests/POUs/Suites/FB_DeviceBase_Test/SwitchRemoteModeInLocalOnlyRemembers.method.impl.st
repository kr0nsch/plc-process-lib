coUnit.TEST('Device_SwitchRemoteModeInLocal_OnlyRemembers');

stCmd.stCommon.xSetAuto := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbDev(xLocal := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
uiHooks := fbDev.uiHookCalls;
fbDev(xLocal := TRUE, xShedToManual := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Local, Message := 'stays Local');
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Manual, Message := 'remembered mode Manual');
AssertEquals_UINT(Expected := uiHooks, Actual := fbDev.uiHookCalls, Message := 'no hook without a mode change');
fbDev(xLocal := FALSE, xShedToManual := FALSE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain,
      stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Manual, Message := 'Manual after Local');

coUnit.TEST_FINISHED();
