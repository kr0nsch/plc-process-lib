coUnit.TEST('Valve_Open_LimitReached_GoesOpen');

stCfg.tTravel := T#10S;
fbVlv.xZsc := TRUE;
// t0: закрыта
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'starts Closed on ZSC');
AssertTrue(Condition := fbVlv.xClosed, Message := 'xClosed on ZSC');
stCmd.xOpen := TRUE;
// t0: команда «открыть»
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'Opening after xOpen');
AssertTrue(Condition := fbVlv.xQOpen, Message := 'open contactor on');
AssertFalse(Condition := fbVlv.xQClose, Message := 'close contactor off');
AssertFalse(Condition := stCmd.xOpen, Message := 'xOpen cleared');
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'open accepted');
// источник: tools/reference/valve_reference.py, сценарий valve_travel_remain (elapsed 0 s)
AssertEquals_UINT(Expected := 10, Actual := fbVlv.stSts.uiTravelRemain_s, Message := 'travel remain 10 s at start');
FOR iStep := 1 TO 20 DO                                                 // t0 + 0,1 … 2,0 с; ZSC пропал на 0,5 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv.xZsc := iStep < 5;
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// источник: tools/reference/valve_reference.py, сценарий valve_travel_remain (elapsed 2.0 s)
AssertEquals_UINT(Expected := 8, Actual := fbVlv.stSts.uiTravelRemain_s, Message := 'travel remain 8 s at t0 + 2 s');
AssertEquals_WORD(Expected := GVL_Const.VLV_STS_OPENING,
                  Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.VLV_STS_OPENING, Message := 'OPENING bit');
FOR iStep := 21 TO 49 DO                                                // до t0 + 4,9 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.xQOpen, Message := 'still opening at t0 + 4.9 s');
fbTime.Advance(tStep := T#100MS);
fbVlv.xZso := TRUE;
// t0 + 5,0 с: ZSO
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open on ZSO');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'contactor off at ZSO');
AssertTrue(Condition := fbVlv.xOpened, Message := 'xOpened');
AssertEquals_WORD(Expected := GVL_Const.VLV_STS_OPENED,
                  Actual := fbVlv.stSts.stCommon.wStatus
                            AND (GVL_Const.VLV_STS_OPENED OR GVL_Const.VLV_STS_CLOSED OR GVL_Const.VLV_STS_OPENING),
                  Message := 'only OPENED of the position bits');
AssertEquals_UDINT(Expected := 1, Actual := stRetain.udiOpCount, Message := 'one open cycle counted');
AssertEquals_UINT(Expected := 0, Actual := fbVlv.stSts.uiTravelRemain_s, Message := 'no travel remain at rest');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'no fault');

coUnit.TEST_FINISHED();
