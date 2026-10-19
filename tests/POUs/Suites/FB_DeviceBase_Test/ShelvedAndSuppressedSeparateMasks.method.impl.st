coUnit.TEST('Device_ShelvedAndSuppressed_SeparateMasks');

SetSlotCfg(stCfgDev := stCfg, uiSlot := 0, ePriority := E_AlarmPriority.Medium, tShelveMax := T#1H);
SetSlotCfg(stCfgDev := stCfg, uiSlot := 1, ePriority := E_AlarmPriority.Medium, tShelveMax := T#1H);
fbDev.axCondIn[0] := TRUE;
fbDev.axCondIn[1] := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.stCommon.wShelveReq := 16#0001;
fbDev.axSuppressIn[1] := TRUE;
fbTime.Advance(tStep := T#1S);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 16#0001, Actual := fbDev.stSts.stCommon.wAlmShelved,
                  Message := 'operator-shelved slot 0 only');
AssertEquals_WORD(Expected := 16#0002, Actual := fbDev.stSts.stCommon.wAlmSuppressed,
                  Message := 'suppressed-by-design slot 1 only');
stCmd.stCommon.xSetOos := TRUE;
fbTime.Advance(tStep := T#1S);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.OutOfService, Message := 'precondition: OutOfService');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmShelved,
                  Message := 'out of service is not shelved');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmSuppressed,
                  Message := 'out of service is not suppressed');

coUnit.TEST_FINISHED();
