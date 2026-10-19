coUnit.TEST('Device_OosRepeatWhileMovingInOos_Accepted');

stCmd.stCommon.xSetOos := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.OutOfService, Message := 'precondition: OutOfService');
uiSeq := fbDev.stSts.stCommon.uiCmdSeq;
stCmd.stCommon.xSetOos := TRUE;
fbDev(xMoving := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.Accepted,
           Message := 'repeated OOS accepted while moving in OOS');
AssertEquals_UINT(Expected := uiSeq + 1, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'counted as a command');
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.OutOfService, Message := 'still OutOfService');
xRet := fbDev.RequestMode(eNewMode := E_DeviceMode.OutOfService);
fbDev(xMoving := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := xRet AND fbDev.stSts.stCommon.eCmdResult = E_CmdResult.Accepted,
           Message := 'RequestMode repeat accepted');
AssertEquals_UINT(Expected := uiSeq + 2, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'second command counted');

coUnit.TEST_FINISHED();
