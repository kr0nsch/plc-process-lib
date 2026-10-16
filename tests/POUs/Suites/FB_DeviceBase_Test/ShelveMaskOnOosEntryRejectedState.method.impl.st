coUnit.TEST('Device_ShelveMaskOnOosEntry_RejectedState');

fbDev.axCondIn[0] := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // слот 0 ActiveUnack
stCmd.stCommon.xSetOos := TRUE;
stCmd.stCommon.wShelveReq := 16#0001;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // OOS и shelve вместе
itfAlm := fbDev.GetAlarm(uiIndex := 0);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.OutOfService, Message := 'device OutOfService');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.RejectedState,
           Message := 'shelve mask on OutOfService entry: RejectedState, not Accepted');
AssertEquals_UINT(Expected := 2, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'mode and mask counted');
stCmd.stCommon.wShelveReq := 16#0001;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // shelve в OOS
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.RejectedState,
           Message := 'shelve mask in OutOfService: RejectedState');
stCmd.stCommon.xSetManual := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // выход из OOS
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack,
           Message := 'after OutOfService: ActiveUnack, not Shelved');

coUnit.TEST_FINISHED();
