coUnit.TEST('Device_DerivedBodyWithoutSuper_BaseBodyNotRun');

stCmd.stCommon.xSetAuto := TRUE;
fbNo(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := 1, Actual := fbNo.uiOwnBodyCalls, Message := 'own body ran');
AssertEquals_UINT(Expected := 0, Actual := fbNo.uiBodyCalls, Message := 'base body did not run');
AssertTrue(Condition := stCmd.stCommon.xSetAuto, Message := 'mode pulse not processed');
AssertTrue(Condition := fbNo.Mode = E_DeviceMode.Manual, Message := 'mode unchanged');
AssertTrue(Condition := fbNo.stSts.stCommon.eDevType = E_DeviceType.None, Message := 'FinishCycle not called');

coUnit.TEST_FINISHED();
