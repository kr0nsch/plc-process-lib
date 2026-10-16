coUnit.TEST('Device_ModeRequestInLocal_ChangesRememberedMode');

fbDev(xLocal := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Local, Message := 'Local');
stCmd.stCommon.xSetAuto := TRUE;
fbDev(xLocal := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'accepted in Local');
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Local, Message := 'still Local');
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Auto, Message := 'remembered mode changed to Auto');
fbDev(xLocal := FALSE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Auto, Message := 'continues in Auto');

coUnit.TEST_FINISHED();
