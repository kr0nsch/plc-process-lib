coUnit.TEST('Device_AlarmPriorityInvalid_CfgErrBit');

uBad.iValue := 9;
SetSlotCfg(stCfgDev := stCfg, uiSlot := 3, ePriority := uBad.ePriority, tShelveMax := T#8H);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 16#0002, Actual := fbDev.stSts.stCommon.wCfgErr,
                  Message := 'wCfgErr bit 1: alarm priority');
AssertTrue(Condition := fbDev.Status = E_Ne107Status.CheckFunction, Message := 'NE 107 CheckFunction');
SetSlotCfg(stCfgDev := stCfg, uiSlot := 3, ePriority := E_AlarmPriority.Critical, tShelveMax := T#8H);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wCfgErr, Message := 'Critical is a valid priority');
AssertTrue(Condition := fbDev.Status = E_Ne107Status.Good, Message := 'NE 107 Good');

coUnit.TEST_FINISHED();
