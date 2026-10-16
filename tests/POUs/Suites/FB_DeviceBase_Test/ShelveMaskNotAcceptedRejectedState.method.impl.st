coUnit.TEST('Device_ShelveMaskNotAccepted_RejectedState');

SetSlotCfg(stCfgDev := stCfg, uiSlot := 1, ePriority := E_AlarmPriority.Medium, tShelveMax := T#0S);
fbDev.axCondIn[1] := TRUE;
fbDev(uiAlarmSlots := 3, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.stCommon.wShelveReq := 16#0002;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.RejectedState,
           Message := 'shelve forbidden: RejectedState');
itfAlm := fbDev.GetAlarm(uiIndex := 1);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'slot stays ActiveUnack');
stCmd.stCommon.wShelveReq := 16#0020;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.RejectedState,
           Message := 'bit of an unused slot: RejectedState');
AssertEquals_UINT(Expected := 2, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'both masks counted');

coUnit.TEST_FINISHED();
