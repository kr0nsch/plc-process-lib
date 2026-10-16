coUnit.TEST('Device_InvalidCfgAtStart_CheckFunctionSafeOutput');

stCfg.rGain := 0.0;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 16#0001, Actual := fbDev.stSts.stCommon.wCfgErr, Message := 'wCfgErr bit 0');
AssertTrue(Condition := fbDev.Status = E_Ne107Status.CheckFunction, Message := 'NE 107 CheckFunction');
AssertEquals_WORD(Expected := GVL_Const.DEV_STS_CFG_ERROR,
                  Actual := fbDev.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_CFG_ERROR, Message := 'cfg error bit');
AssertEquals_REAL(Expected := 0.0, Actual := fbDev.rOut_eu, Delta := 0.0, Message := 'safe value without valid cfg');
stCmd.xStart := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.stSts.stCommon.eCmdResult = E_CmdResult.RejectedCfg,
           Message := 'start rejected: RejectedCfg');
AssertFalse(Condition := fbDev.xOutput, Message := 'output off');
stCmd.stCommon.xSetAuto := TRUE;
fbDev(xAutoRun := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Auto, Message := 'mode commands work without valid cfg');
AssertFalse(Condition := fbDev.xOutput, Message := 'safe output in Auto with request');
AssertFalse(Condition := fbDev.Available, Message := 'not available without valid cfg');

coUnit.TEST_FINISHED();
