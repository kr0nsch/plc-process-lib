coUnit.TEST('Device_OosExitWithLocalSelected_GoesLocal');

stCmd.stCommon.xSetOos := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbDev(xLocal := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.OutOfService, Message := 'OutOfService overrides Local');
stCmd.stCommon.xSetManual := TRUE;
fbDev(xLocal := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Local,
           Message := 'leaving OutOfService with Local selected -> Local');
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Manual, Message := 'remembered mode Manual');

coUnit.TEST_FINISHED();
