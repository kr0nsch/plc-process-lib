coUnit.TEST('Device_StsHeader_AllFieldsFilled');

SetSlotCfg(stCfgDev := stCfg, uiSlot := 0, ePriority := E_AlarmPriority.High, tShelveMax := T#8H);
fbDev(eTypeSel := E_DeviceType.ControlValve, wWarnIn := 16#0004, itfTime := fbTime, stCmd := stCmd,
      stRetain := stRetain, stCfg := stCfg);
stCmd.xStart := TRUE;
fbDev.axCondIn[0] := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stHdr := fbDev.stSts.stCommon;
AssertEquals_WORD(Expected := 16#C201, Actual := stHdr.wStatus, Message := 'unack, warning, Manual, output bits');
AssertEquals_WORD(Expected := 0, Actual := stHdr.wFault, Message := 'wFault');
AssertEquals_WORD(Expected := 16#0004, Actual := stHdr.wWarning, Message := 'wWarning');
AssertEquals_WORD(Expected := 0, Actual := stHdr.wCfgErr, Message := 'wCfgErr');
AssertTrue(Condition := stHdr.eMode = E_DeviceMode.Manual, Message := 'eMode');
AssertTrue(Condition := stHdr.eNe107 = E_Ne107Status.Good, Message := 'eNe107');
AssertTrue(Condition := stHdr.eCmdResult = E_CmdResult.Accepted, Message := 'eCmdResult');
AssertEquals_UINT(Expected := 1, Actual := stHdr.uiCmdSeq, Message := 'uiCmdSeq');
AssertEquals_WORD(Expected := 16#0001, Actual := stHdr.wAlmActive, Message := 'wAlmActive');
AssertEquals_WORD(Expected := 16#0001, Actual := stHdr.wAlmUnack, Message := 'wAlmUnack');
AssertEquals_WORD(Expected := 0, Actual := stHdr.wAlmShelved, Message := 'wAlmShelved');
AssertTrue(Condition := stHdr.ePrioUnack = E_AlarmPriority.High, Message := 'ePrioUnack');
AssertTrue(Condition := stHdr.eDevType = E_DeviceType.ControlValve, Message := 'eDevType');
AssertEquals_WORD(Expected := 0, Actual := stHdr.wReserve, Message := 'wReserve');

coUnit.TEST_FINISHED();
