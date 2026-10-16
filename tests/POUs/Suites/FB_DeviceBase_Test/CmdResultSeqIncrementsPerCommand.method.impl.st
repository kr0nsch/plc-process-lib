coUnit.TEST('Device_CmdResult_SeqIncrementsPerCommand');

SetSlotCfg(stCfgDev := stCfg, uiSlot := 0, ePriority := E_AlarmPriority.Medium, tShelveMax := T#0S);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := 0, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'no commands yet');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.None, Message := 'result None before commands');
stCmd.xStart := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := 1, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'start counted');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'start accepted in Manual');
stCmd.stCommon.xSetAuto := TRUE;
stCmd.xStart := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := 3, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'two commands in one call');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.RejectedMode,
           Message := 'last result: start in Auto rejected');
stCmd.stCommon.xReset := TRUE;
stCmd.stCommon.wShelveReq := 16#0001;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := 5, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'reset and shelve mask');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.RejectedState,
           Message := 'last result: shelve rejected');

coUnit.TEST_FINISHED();
