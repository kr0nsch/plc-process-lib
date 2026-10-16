coUnit.TEST('Device_SummaryStatus_MaxOfDeviceModeAndCfg');

stCmd.stCommon.xSetAuto := TRUE;
fbDev(eDevStatusIn := E_Ne107Status.OutOfSpecification, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain,
      stCfg := stCfg);
AssertTrue(Condition := fbDev.Status = E_Ne107Status.OutOfSpecification, Message := 'S from the device');
AssertEquals_WORD(Expected := 16#4100, Actual := fbDev.stSts.stCommon.wStatus, Message := 'Auto and warning bits');
fbDev(eDevStatusIn := E_Ne107Status.MaintenanceRequired, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain,
      stCfg := stCfg);
AssertTrue(Condition := fbDev.Status = E_Ne107Status.MaintenanceRequired, Message := 'M from the device');
AssertEquals_WORD(Expected := 16#4100, Actual := fbDev.stSts.stCommon.wStatus, Message := 'warning bit for M');
stCfg.rGain := 0.0;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Status = E_Ne107Status.CheckFunction, Message := 'cfg C over device M');
AssertEquals_WORD(Expected := 16#1100, Actual := fbDev.stSts.stCommon.wStatus, Message := 'Auto and cfg error bits');
stCfg.rGain := 2.0;
stCmd.stCommon.xSetOos := TRUE;
fbDev(eDevStatusIn := E_Ne107Status.Failure, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Status = E_Ne107Status.Failure, Message := 'F over OutOfService C');
AssertTrue(Condition := fbDev.Fault, Message := 'Fault = (Status = Failure)');
AssertEquals_WORD(Expected := 16#2800, Actual := fbDev.stSts.stCommon.wStatus,
                  Message := 'OutOfService and failure bits');
fbDev(eDevStatusIn := E_Ne107Status.Good, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Status = E_Ne107Status.CheckFunction, Message := 'OutOfService gives C');
fbIn(xInputLike := TRUE, xLocalSupported := FALSE, itfTime := fbTime, stCmd := stCmdIn, stRetain := stRetainIn,
     stCfg := stCfg);
AssertTrue(Condition := fbIn.Status = E_Ne107Status.Good, Message := 'input-like device: Auto (measurement) is Good');
stCmdIn.stCommon.xSetManual := TRUE;
fbIn(itfTime := fbTime, stCmd := stCmdIn, stRetain := stRetainIn, stCfg := stCfg);
AssertTrue(Condition := fbIn.Status = E_Ne107Status.CheckFunction,
           Message := 'input-like device: Manual (substitution) is C');

coUnit.TEST_FINISHED();
