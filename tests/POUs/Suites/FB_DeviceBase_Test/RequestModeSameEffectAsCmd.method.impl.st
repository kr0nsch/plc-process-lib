coUnit.TEST('Device_RequestMode_SameEffectAsCmd');

xRet := fbDev.RequestMode(eNewMode := E_DeviceMode.Auto);
AssertTrue(Condition := xRet, Message := 'Auto request accepted');
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Manual, Message := 'request only: no change before the body call');
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Auto, Message := 'Auto after the body call');
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Auto, Message := 'stored in retain like the command bit');
AssertEquals_UINT(Expected := 1, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'counted as a command');
fbDev.RequestMode(eNewMode := E_DeviceMode.OutOfService);
fbDev(xMoving := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.RejectedState,
           Message := 'OutOfService while moving: RejectedState');
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Auto, Message := 'mode unchanged');
stCmd.stCommon.xSetOos := TRUE;
fbDev(xMoving := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.RejectedState,
           Message := 'same result through the command bit');
AssertEquals_UINT(Expected := 3, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'three commands');
fbDev.RequestMode(eNewMode := E_DeviceMode.OutOfService);
fbDev(xMoving := FALSE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.OutOfService, Message := 'OutOfService when the mechanism stands');

coUnit.TEST_FINISHED();
