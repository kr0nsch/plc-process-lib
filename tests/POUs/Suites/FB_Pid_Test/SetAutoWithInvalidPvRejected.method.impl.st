coUnit.TEST('Pid_SetAutoWithInvalidPv_Rejected');
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := FALSE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
stCmd.stCommon.xSetAuto := TRUE;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbPid.stSts.stCommon.eCmdResult = E_CmdResult.RejectedFault, Message := 'RejectedFault');
AssertFalse(Condition := stCmd.stCommon.xSetAuto, Message := 'xSetAuto cleared');
AssertTrue(Condition := fbPid.Mode = E_DeviceMode.Manual, Message := 'stays Manual');
AssertEquals_UINT(Expected := 1, Actual := fbPid.stSts.stCommon.uiCmdSeq, Message := 'one command');
xReqOk := fbPid.RequestMode(eNewMode := E_DeviceMode.Auto);
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := xReqOk, Message := 'RequestMode(Auto) queued');
AssertTrue(Condition := fbPid.stSts.stCommon.eCmdResult = E_CmdResult.RejectedFault,
           Message := 'method: RejectedFault');
AssertTrue(Condition := fbPid.Mode = E_DeviceMode.Manual, Message := 'still Manual');
AssertEquals_UINT(Expected := 2, Actual := fbPid.stSts.stCommon.uiCmdSeq, Message := 'second command');
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Manual, Message := 'retain not changed');
coUnit.TEST_FINISHED();
