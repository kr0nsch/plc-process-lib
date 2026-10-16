coUnit.TEST('Device_InputLike_ModeMemStartsAutoManualIsCheck');

stRetain.eRemoteMode := E_DeviceMode.Manual;
fbIn(xInputLike := TRUE, xLocalSupported := FALSE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain,
     stCfg := stCfg);
AssertTrue(Condition := fbIn.Mode = E_DeviceMode.Auto, Message := 'starts in Auto (measurement)');
fbIn(xLocal := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbIn.Mode = E_DeviceMode.Auto, Message := 'no Local mode');
stCmd.stCommon.xSetManual := TRUE;
fbIn(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbIn.Mode = E_DeviceMode.Manual, Message := 'Manual (substitution)');
AssertTrue(Condition := fbIn.Status = E_Ne107Status.CheckFunction, Message := 'substitution gives CheckFunction');
AssertTrue(Condition := fbIn.stModeMem.eRemoteMode = E_DeviceMode.Manual, Message := 'mode kept in stModeMem');
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbIn(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbIn.Mode = E_DeviceMode.Manual, Message := 'stRetain is not used');

coUnit.TEST_FINISHED();
