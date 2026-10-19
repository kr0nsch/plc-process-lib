coUnit.TEST('Device_LocalMode_Ne107CheckFunction');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.eNe107 = E_Ne107Status.Good, Message := 'precondition: Good in Auto');
fbDev(xLocal := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Local, Message := 'precondition: Local');
AssertTrue(Condition := fbDev.stSts.stCommon.eNe107 = E_Ne107Status.CheckFunction,
           Message := 'Local is function check');
AssertTrue(Condition := fbDev.Status = E_Ne107Status.CheckFunction, Message := 'Status through I_Device');
AssertFalse(Condition := fbDev.Available, Message := 'not available in Local');
fbDev(xLocal := TRUE, eDevStatusIn := E_Ne107Status.Failure, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain,
      stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.eNe107 = E_Ne107Status.Failure,
           Message := 'failure ranks above function check');
fbDev(xLocal := FALSE, eDevStatusIn := E_Ne107Status.Good, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain,
      stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.eNe107 = E_Ne107Status.Good, Message := 'Good again in Auto');

coUnit.TEST_FINISHED();
