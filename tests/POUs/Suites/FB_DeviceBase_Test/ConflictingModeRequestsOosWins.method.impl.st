coUnit.TEST('Device_ConflictingModeRequests_OosWins');

fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Manual
stCmd.stCommon.xSetAuto := TRUE;
stCmd.stCommon.xSetManual := TRUE;
stCmd.stCommon.xSetOos := TRUE;
xRet := fbDev.RequestMode(eNewMode := E_DeviceMode.Auto);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := xRet, Message := 'RequestMode(Auto) accepted as a request');
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.OutOfService, Message := 'OutOfService wins');
AssertTrue(Condition := stRetain.xOutOfService, Message := 'OutOfService stored in retain');
AssertEquals_UINT(Expected := 1, Actual := fbDev.stSts.stCommon.uiCmdSeq,
                  Message := 'simultaneous mode requests are one command');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'accepted');
AssertFalse(Condition := stCmd.stCommon.xSetAuto OR stCmd.stCommon.xSetManual OR stCmd.stCommon.xSetOos,
            Message := 'mode pulses cleared');
stCmd.stCommon.xSetAuto := TRUE;
fbDev.RequestMode(eNewMode := E_DeviceMode.Manual);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Manual, Message := 'Manual wins over Auto');
AssertFalse(Condition := stRetain.xOutOfService, Message := 'Manual leaves OutOfService');
AssertEquals_UINT(Expected := 2, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'second command');

coUnit.TEST_FINISHED();
