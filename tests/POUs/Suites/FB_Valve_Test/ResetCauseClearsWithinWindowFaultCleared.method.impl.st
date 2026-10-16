coUnit.TEST('Valve_Reset_CauseClearsWithinWindow_FaultCleared');

stCfg.xTorqueUsed := TRUE;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
fbVlv.xTorqueOpen := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_TORQUE_TRIP, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'TorqueTrip');
stCmd.stCommon.xReset := TRUE;
// t1: Reset, муфта сработана
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
uiSeq := fbVlv.stSts.stCommon.uiCmdSeq;
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_TORQUE_TRIP, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'cause active right after Reset');
FOR iStep := 1 TO 9 DO                                                  // t1 + 0,9 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_TORQUE_TRIP, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'still faulted while torque is on');
fbVlv.xTorqueOpen := FALSE;
fbTime.Advance(tStep := T#100MS);
// t1 + 1,0 с: муфта отпустила
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'cleared within the window');
FOR iStep := 1 TO 30 DO                                                 // дальше конца окна
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_UINT(Expected := uiSeq, Actual := fbVlv.stSts.stCommon.uiCmdSeq, Message := 'no second result');
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'last result Accepted');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'no restart in Manual');

coUnit.TEST_FINISHED();
