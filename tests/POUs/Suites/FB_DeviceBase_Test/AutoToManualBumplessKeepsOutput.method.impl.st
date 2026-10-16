coUnit.TEST('Device_AutoToManual_BumplessKeepsOutput');

stCmd.stCommon.xSetAuto := TRUE;
fbDev(xAutoRun := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.xOutput, Message := 'running in Auto');
stCmd.stCommon.xSetManual := TRUE;
fbDev(xAutoRun := FALSE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Manual, Message := 'Manual');
AssertTrue(Condition := fbDev.xOutput, Message := 'keeps running after Auto -> Manual');

coUnit.TEST_FINISHED();
