coUnit.TEST('Valve_CloseOnTorque_CompletesClosing');

stCfg.xTorqueUsed := TRUE;
stCfg.xCloseOnTorque := TRUE;
fbVlv.xZso := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xClose := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZso := FALSE;
FOR iStep := 1 TO 30 DO                                                 // закрывается 3 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
fbVlv.xTorqueClose := TRUE;
fbTime.Advance(tStep := T#100MS);
// клин сел: муфта закрытия
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'Closed on torque');
AssertFalse(Condition := fbVlv.xQClose, Message := 'output off');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'no torque trip');
AssertTrue(Condition := fbVlv.xClosed, Message := 'xClosed without ZSC');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wWarning AND GVL_Const.VLV_WRN_POSITION_BY_TIME,
                  Message := 'closed by torque, not by time');
fbVlv.xTorqueClose := FALSE;
FOR iStep := 1 TO 20 DO                                                 // 2 с: ZSC так и не сработал
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'no PositionLost: end position was not confirmed by ZSC');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'stays Closed');

coUnit.TEST_FINISHED();
