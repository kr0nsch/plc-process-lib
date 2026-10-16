coUnit.TEST('Valve_Close_LimitReached_GoesClosed');

stCfg.tTravel := T#10S;
fbVlv.xZso := TRUE;
// t0: открыта
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'starts Open on ZSO');
stCmd.xClose := TRUE;
// t0: команда «закрыть»
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closing, Message := 'Closing after xClose');
AssertTrue(Condition := fbVlv.xQClose, Message := 'close contactor on');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'open contactor off');
AssertFalse(Condition := stCmd.xClose, Message := 'xClose cleared');
AssertEquals_WORD(Expected := GVL_Const.VLV_STS_CLOSING,
                  Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.VLV_STS_CLOSING, Message := 'CLOSING bit');
FOR iStep := 1 TO 29 DO                                                 // t0 + 0,1 … 2,9 с; ZSO пропал на 0,3 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv.xZso := iStep < 3;
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.xQClose, Message := 'still closing at t0 + 2.9 s');
fbTime.Advance(tStep := T#100MS);
fbVlv.xZsc := TRUE;
// t0 + 3,0 с: ZSC
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'Closed on ZSC');
AssertFalse(Condition := fbVlv.xQClose, Message := 'contactor off at ZSC');
AssertTrue(Condition := fbVlv.xClosed, Message := 'xClosed');
AssertFalse(Condition := fbVlv.xOpened, Message := 'not xOpened');
AssertEquals_WORD(Expected := GVL_Const.VLV_STS_CLOSED,
                  Actual := fbVlv.stSts.stCommon.wStatus AND (GVL_Const.VLV_STS_OPENED OR GVL_Const.VLV_STS_CLOSED),
                  Message := 'CLOSED bit');
AssertEquals_UDINT(Expected := 0, Actual := stRetain.udiOpCount, Message := 'closing is not an open cycle');

coUnit.TEST_FINISHED();
