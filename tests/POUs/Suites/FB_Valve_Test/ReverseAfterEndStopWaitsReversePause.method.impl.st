coUnit.TEST('Valve_ReverseAfterEndStop_WaitsReversePause');

fbVlv.xZsc := TRUE;
// закрыта
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
FOR iStep := 1 TO 20 DO                                                 // открывается 2 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
fbVlv.xZso := TRUE;
fbTime.Advance(tStep := T#100MS);
// t1: ZSO, выход «открывать» снят
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open on ZSO');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'open contactor off at ZSO');
stCmd.xClose := TRUE;
fbTime.Advance(tStep := T#100MS);
// t1 + 0,1 с: команда «закрыть»
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'close accepted');
xEverOn := fbVlv.xQOpen OR fbVlv.xQClose;
FOR iStep := 1 TO 8 DO                                                  // до t1 + 0,9 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    xEverOn := xEverOn OR fbVlv.xQOpen OR fbVlv.xQClose;
END_FOR
AssertFalse(Condition := xEverOn, Message := 'no reverse start within tReverse after end stop');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'waits at Open');
fbTime.Advance(tStep := T#100MS);
// t1 + 1,0 с
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closing, Message := 'Closing at t1 + tReverse');
AssertTrue(Condition := fbVlv.xQClose, Message := 'close contactor on at t1 + tReverse');
fbVlv.xZso := FALSE;
FOR iStep := 1 TO 20 DO                                                 // закрывается 2 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
stCmd.xStop := TRUE;
// t2: стоп в ходе
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Intermediate, Message := 'Intermediate after stop');
stCmd.xOpen := TRUE;
fbTime.Advance(tStep := T#200MS);
// t2 + 0,2 с: команда «открыть»
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'open accepted');
xEverOn := fbVlv.xQOpen OR fbVlv.xQClose;
FOR iStep := 1 TO 7 DO                                                  // до t2 + 0,9 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    xEverOn := xEverOn OR fbVlv.xQOpen OR fbVlv.xQClose;
END_FOR
AssertFalse(Condition := xEverOn, Message := 'no reverse start within tReverse after stop');
fbTime.Advance(tStep := T#100MS);
// t2 + 1,0 с
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'Opening at t2 + tReverse');
AssertTrue(Condition := fbVlv.xQOpen, Message := 'open contactor on at t2 + tReverse');

coUnit.TEST_FINISHED();
