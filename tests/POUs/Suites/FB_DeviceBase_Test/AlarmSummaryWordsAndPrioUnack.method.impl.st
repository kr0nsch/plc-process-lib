coUnit.TEST('Device_AlarmSummary_WordsAndPrioUnack');

SetSlotCfg(stCfgDev := stCfg, uiSlot := 0, ePriority := E_AlarmPriority.Low, tShelveMax := T#8H);
SetSlotCfg(stCfgDev := stCfg, uiSlot := 1, ePriority := E_AlarmPriority.High, tShelveMax := T#8H);
SetSlotCfg(stCfgDev := stCfg, uiSlot := 2, ePriority := E_AlarmPriority.Medium, tShelveMax := T#8H);
fbDev.axCondIn[0] := TRUE;
fbDev.axCondIn[1] := TRUE;
fbDev.axCondIn[2] := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.ePrioUnack = E_AlarmPriority.High,
           Message := 'highest unacknowledged: High');
stCmd.stCommon.wAckReq := 16#0002;
fbDev.axCondIn[2] := FALSE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.ePrioUnack = E_AlarmPriority.Medium,
           Message := 'High acknowledged: Medium');
AssertEquals_WORD(Expected := 16#0003, Actual := fbDev.stSts.stCommon.wAlmActive, Message := 'slots 0 and 1 active');
AssertEquals_WORD(Expected := 16#0005, Actual := fbDev.stSts.stCommon.wAlmUnack,
                  Message := 'slots 0 and 2 unacknowledged');
fbDev.axSuppressIn[0] := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 16#0001, Actual := fbDev.stSts.stCommon.wAlmSuppressed,
                  Message := 'suppressed slot 0 in wAlmSuppressed');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmShelved, Message := 'suppression is not shelving');
AssertEquals_WORD(Expected := 16#0004, Actual := fbDev.stSts.stCommon.wAlmUnack,
                  Message := 'suppression clears unacknowledged');

coUnit.TEST_FINISHED();
