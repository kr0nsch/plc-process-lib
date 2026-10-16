coUnit.TEST('Valve_NoLimitSwitches_PositionByTravelTime');

stCfg.xZsoUsed := FALSE;
stCfg.xZscUsed := FALSE;
stCfg.tTravel := T#10S;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Unknown, Message := 'Unknown without limit switches');
AssertEquals_WORD(Expected := GVL_Const.VLV_WRN_POSITION_UNKNOWN,
                  Actual := fbVlv.stSts.stCommon.wWarning AND GVL_Const.VLV_WRN_POSITION_UNKNOWN,
                  Message := 'POSITION_UNKNOWN warning');
stCmd.xOpen := TRUE;
// t0
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 99 DO                                                 // t0 + 9,9 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'Opening at t0 + 9.9 s');
AssertTrue(Condition := fbVlv.xQOpen, Message := 'output held until tTravel');
fbTime.Advance(tStep := T#100MS);
// t0 + 10,0 с
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open by travel time');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'output off');
AssertTrue(Condition := fbVlv.xOpened, Message := 'xOpened');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'no fault without limit switch');
AssertEquals_WORD(Expected := GVL_Const.VLV_WRN_POSITION_BY_TIME,
                  Actual := fbVlv.stSts.stCommon.wWarning AND GVL_Const.VLV_WRN_POSITION_BY_TIME,
                  Message := 'POSITION_BY_TIME warning');
fbVlv.xZsc := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'unused ZSC ignored');

coUnit.TEST_FINISHED();
