coUnit.TEST('Device_RequestModeLocal_ReturnsFalse');

xRet := fbDev.RequestMode(eNewMode := E_DeviceMode.Local);
AssertFalse(Condition := xRet, Message := 'Local cannot be requested');
uBad.iValue := 9;
xRet := fbDev.RequestMode(eNewMode := uBad.eMode);
AssertFalse(Condition := xRet, Message := 'value outside the enumeration rejected');
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Manual, Message := 'mode unchanged');
AssertEquals_UINT(Expected := 0, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'no command counted');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.None, Message := 'no result');

coUnit.TEST_FINISHED();
