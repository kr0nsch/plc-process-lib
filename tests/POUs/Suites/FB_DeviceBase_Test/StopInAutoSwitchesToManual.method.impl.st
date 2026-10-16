coUnit.TEST('Device_StopInAuto_SwitchesToManual');

stCmd.stCommon.xSetAuto := TRUE;
fbDev(xAutoRun := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.xOutput, Message := 'running in Auto');
stCmd.xStop := TRUE;
fbDev(xAutoRun := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Manual, Message := 'stop in Auto switches to Manual');
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Manual, Message := 'stored in retain');
AssertFalse(Condition := fbDev.xOutput, Message := 'stopped');
AssertTrue(Condition := fbDev.eHookOld = E_DeviceMode.Auto AND fbDev.eHookNew = E_DeviceMode.Manual,
           Message := 'hook Auto -> Manual');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'stop accepted');

coUnit.TEST_FINISHED();
