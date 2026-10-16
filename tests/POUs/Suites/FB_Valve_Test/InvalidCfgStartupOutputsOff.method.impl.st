coUnit.TEST('Valve_InvalidCfg_StartupOutputsOff');

stCfg.tTravel := T#0S;
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbVlv.xAutoOpen := TRUE;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_CFG_TRAVEL, Actual := fbVlv.stSts.stCommon.wCfgErr,
                  Message := 'wCfgErr VLV_CFG_TRAVEL');
AssertTrue(Condition := fbVlv.Status = E_Ne107Status.CheckFunction, Message := 'NE 107 CheckFunction');
AssertEquals_WORD(Expected := GVL_Const.DEV_STS_CFG_ERROR,
                  Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_CFG_ERROR, Message := 'CFG_ERROR bit');
AssertFalse(Condition := fbVlv.Available, Message := 'not available without valid cfg');
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    xEverOn := xEverOn OR fbVlv.xQOpen OR fbVlv.xQClose OR fbVlv.xQCoil;
END_FOR
AssertFalse(Condition := xEverOn, Message := 'outputs off without valid cfg');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'state tracks limit switches');
stCmd.xOpen := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.RejectedCfg, Message := 'RejectedCfg');
AssertTrue(Condition := fbVlv.Mode = E_DeviceMode.Auto, Message := 'rejected command keeps Auto');
stCfg.tTravel := T#60S;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wCfgErr, Message := 'cfg valid');
AssertTrue(Condition := fbVlv.xQOpen, Message := 'drives to target once cfg is valid');

coUnit.TEST_FINISHED();
