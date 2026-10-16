coUnit.TEST('Device_RetainModeInvalid_SanitizedToManual');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Auto, Message := 'remote mode Auto from retain');
uBad.iValue := 7;
stRetain.eRemoteMode := uBad.eMode;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Manual, Message := 'value 7 written back as Manual');
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Manual, Message := 'device runs in Manual');
uBad.iValue := 0;
stRetain.eRemoteMode := uBad.eMode;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Manual,
           Message := 'value 0 (cleared memory) written back as Manual');
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Manual, Message := 'still Manual');
AssertEquals_UINT(Expected := 0, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'sanitization is not a command');

coUnit.TEST_FINISHED();
