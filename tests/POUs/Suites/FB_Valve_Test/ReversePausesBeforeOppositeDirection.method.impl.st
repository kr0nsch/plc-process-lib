coUnit.TEST('Valve_Reverse_PausesBeforeOppositeDirection');

fbVlv.xZsc := TRUE;
// закрыта
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
// Opening
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
FOR iStep := 1 TO 20 DO                                                 // открывается 2 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.xQOpen, Message := 'opening');
stCmd.xClose := TRUE;
// t1: смена направления
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Reversing, Message := 'Reversing on direction change');
AssertFalse(Condition := fbVlv.xQOpen OR fbVlv.xQClose, Message := 'both outputs off during the pause');
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'close accepted');
FOR iStep := 1 TO 9 DO                                                  // t1 + 0,9 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    xEverOn := xEverOn OR fbVlv.xQOpen OR fbVlv.xQClose;
END_FOR
AssertFalse(Condition := xEverOn, Message := 'outputs stay off before tReverse');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Reversing, Message := 'still reversing at t1 + 0.9 s');
fbTime.Advance(tStep := T#100MS);
// t1 + 1,0 с
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closing, Message := 'Closing after tReverse');
AssertTrue(Condition := fbVlv.xQClose, Message := 'close contactor on');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'open contactor off');

coUnit.TEST_FINISHED();
