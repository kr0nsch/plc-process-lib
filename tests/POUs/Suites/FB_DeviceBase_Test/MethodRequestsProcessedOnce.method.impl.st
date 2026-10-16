coUnit.TEST('Device_MethodRequests_ProcessedOnce');

fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbDev.Reset();
FOR iStep := 1 TO 3 DO
    fbTime.Advance(tStep := T#100MS);
    fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_UINT(Expected := 1, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'Reset() executed once');
fbDev.axCondIn[0] := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 16#0001, Actual := fbDev.stSts.stCommon.wAlmUnack,
                  Message := 'alarm after Reset() stays unacknowledged');
AssertEquals_UINT(Expected := 1, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'no repeated reset');

fbDev.AckAll();
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmUnack, Message := 'AckAll() acknowledged');
fbDev.axCondIn[1] := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 16#0002, Actual := fbDev.stSts.stCommon.wAlmUnack,
                  Message := 'alarm after AckAll() stays unacknowledged');
AssertEquals_UINT(Expected := 2, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'AckAll() executed once');

fbDev.RequestMode(eNewMode := E_DeviceMode.Auto);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Auto, Message := 'RequestMode(Auto) executed');
stCmd.stCommon.xSetManual := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Manual, Message := 'old RequestMode(Auto) does not come back');
AssertEquals_UINT(Expected := 4, Actual := fbDev.stSts.stCommon.uiCmdSeq, Message := 'four commands in total');

coUnit.TEST_FINISHED();
