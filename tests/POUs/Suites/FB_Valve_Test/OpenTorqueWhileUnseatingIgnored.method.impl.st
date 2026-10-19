coUnit.TEST('Valve_OpenTorqueWhileUnseating_Ignored');

stCfg.xTorqueUsed := TRUE;
stCfg.xCloseOnTorque := TRUE;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Closed по ZSC (старт ПЛК)
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'precondition: Closed');
stCmd.xOpen := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t1: Opening
AssertTrue(Condition := fbVlv.xQOpen, Message := 'precondition: opening');
fbVlv.xTorqueOpen := TRUE;                                                             // страгивание клина
FOR iStep := 1 TO 3 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.xQOpen, Message := 'unseating torque ignored while ZSC is made');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'no TorqueTrip at unseating');
fbVlv.xZsc := FALSE;                                                                   // t1 + 0,4 с: клин вышел
FOR iStep := 1 TO 5 DO                                                               // t1 + 0,4 … t1 + 0,8 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.xQOpen, Message := 'bypass held for tLimitFilter after ZSC released');
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t1 + 0,9 с: ZSC разомкнут 0,5 с
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_TORQUE_TRIP, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'torque after unseating trips');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'output off');

coUnit.TEST_FINISHED();
