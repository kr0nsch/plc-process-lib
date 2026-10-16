coUnit.TEST('Device_DevTypeSetByHeir_ReportedInStsCommon');

AssertTrue(Condition := fbDev.stSts.stCommon.eDevType = E_DeviceType.None, Message := 'None before the first call');
fbDev(eTypeSel := E_DeviceType.Pid, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.eDevType = E_DeviceType.Pid, Message := 'type set by the heir');

coUnit.TEST_FINISHED();
