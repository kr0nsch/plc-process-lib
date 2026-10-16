coUnit.TEST('Device_ShelveMask_ShelvesSlotForMax');

SetSlotCfg(stCfgDev := stCfg, uiSlot := 2, ePriority := E_AlarmPriority.Medium, tShelveMax := T#1H);
fbDev.axCondIn[2] := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.stCommon.wShelveReq := 16#0004;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0
itfAlm := fbDev.GetAlarm(uiIndex := 2);
AssertTrue(Condition := itfAlm.State = E_AlarmState.Shelved, Message := 'slot 2 shelved');
AssertEquals_WORD(Expected := 16#0004, Actual := fbDev.stSts.stCommon.wAlmShelved, Message := 'shelved bit');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmUnack, Message := 'no unacknowledged alarm');
AssertEquals_WORD(Expected := 0, Actual := stCmd.stCommon.wShelveReq, Message := 'mask cleared');
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'shelve mask accepted');
FOR iStep := 1 TO 5 DO
    fbTime.Advance(tStep := T#10M);
    fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := itfAlm.State = E_AlarmState.Shelved, Message := 'still shelved at 50 min');
fbTime.Advance(tStep := T#10M);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0 + 1 ч
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'reannunciated after tShelveMax');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmShelved, Message := 'shelved bit cleared');

coUnit.TEST_FINISHED();
