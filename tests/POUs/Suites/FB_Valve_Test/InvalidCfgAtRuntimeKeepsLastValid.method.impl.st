coUnit.TEST('Valve_InvalidCfgAtRuntime_KeepsLastValid');

stCfg.tTravel := T#10S;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
// t0
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
FOR iStep := 1 TO 20 DO                                                 // t0 + 2,0 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
stCfg.tTravel := T#0S;
fbTime.Advance(tStep := T#100MS);
// t0 + 2,1 с: Cfg испорчена
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_CFG_TRAVEL, Actual := fbVlv.stSts.stCommon.wCfgErr, Message := 'wCfgErr');
AssertTrue(Condition := fbVlv.Status = E_Ne107Status.CheckFunction, Message := 'NE 107 CheckFunction');
AssertTrue(Condition := fbVlv.xQOpen, Message := 'keeps running with the last valid cfg');
FOR iStep := 1 TO 78 DO                                                 // t0 + 9,9 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'Opening at t0 + 9.9 s');
fbTime.Advance(tStep := T#100MS);
// t0 + 10,0 с
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_FAIL_TO_OPEN, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'travel supervised with the last valid tTravel');

coUnit.TEST_FINISHED();
