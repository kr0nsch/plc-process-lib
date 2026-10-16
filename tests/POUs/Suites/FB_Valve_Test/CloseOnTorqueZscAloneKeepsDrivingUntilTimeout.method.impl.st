coUnit.TEST('Valve_CloseOnTorque_ZscAloneKeepsDrivingUntilTimeout');

stCfg.tTravel := T#10S;
stCfg.xTorqueUsed := TRUE;
stCfg.xCloseOnTorque := TRUE;
fbVlv.xZso := TRUE;
// t0: открыта
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xClose := TRUE;
// t0: Closing
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZso := FALSE;
FOR iStep := 1 TO 30 DO                                                 // до t0 + 3,0 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
fbVlv.xZsc := TRUE;
FOR iStep := 1 TO 69 DO                                                 // ZSC есть, муфты нет: до t0 + 9,9 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closing, Message := 'still closing on ZSC alone');
AssertTrue(Condition := fbVlv.xQClose, Message := 'close output held until torque');
AssertFalse(Condition := fbVlv.xClosed, Message := 'not closed before torque');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'no fault before tTravel');
fbTime.Advance(tStep := T#100MS);
// t0 + 10,0 с: муфта не сработала
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Fault, Message := 'Fault at tTravel');
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_FAIL_TO_CLOSE, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'wFault FailToClose');
AssertFalse(Condition := fbVlv.xQClose, Message := 'output off on timeout');
AssertTrue(Condition := fbVlv.xClosed, Message := 'ZSC position visible in Fault');
stCmd.stCommon.xReset := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'cleared by Reset');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'Closed by ZSC after Reset');
AssertFalse(Condition := fbVlv.xQClose, Message := 'no output after Reset');

coUnit.TEST_FINISHED();
