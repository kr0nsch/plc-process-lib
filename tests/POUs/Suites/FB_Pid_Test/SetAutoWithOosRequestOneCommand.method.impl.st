coUnit.TEST('Pid_SetAutoWithOosRequest_OneCommand');
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := FALSE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual, PV негодна
stCmd.stCommon.xSetAuto := TRUE;
stCmd.stCommon.xSetOos := TRUE;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbPid.Mode = E_DeviceMode.OutOfService, Message := 'OutOfService wins');
AssertTrue(Condition := fbPid.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'result of the winner');
AssertEquals_UINT(Expected := 1, Actual := fbPid.stSts.stCommon.uiCmdSeq, Message := 'one command');
AssertFalse(Condition := stCmd.stCommon.xSetAuto, Message := 'xSetAuto cleared');
AssertFalse(Condition := stCmd.stCommon.xSetOos, Message := 'xSetOos cleared');
coUnit.TEST_FINISHED();
