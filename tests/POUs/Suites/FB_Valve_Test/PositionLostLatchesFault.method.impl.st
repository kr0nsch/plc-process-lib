coUnit.TEST('Valve_PositionLost_LatchesFault');

fbVlv.xZso := TRUE;
// открыта
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZso := FALSE;
// t0: провал ZSO
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 3 DO                                                  // t0 + 0,3 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
fbVlv.xZso := TRUE;
fbTime.Advance(tStep := T#100MS);
// t0 + 0,4 с: вернулся
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'short loss filtered');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'still Open');
fbVlv.xZso := FALSE;
fbTime.Advance(tStep := T#100MS);
// t1: ZSO пропал
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 4 DO                                                  // t1 + 0,4 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'no fault before tLimitFilter');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'state held during the filter');
fbTime.Advance(tStep := T#100MS);
// t1 + 0,5 с
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_POSITION_LOST, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'PositionLost');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Fault, Message := 'Fault state');
fbVlv.xZso := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_POSITION_LOST, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'latched after the limit switch returns');
stCmd.stCommon.xReset := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'cleared by Reset');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open after Reset');

coUnit.TEST_FINISHED();
