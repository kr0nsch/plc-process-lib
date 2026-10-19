coUnit.TEST('Valve_OpenTorqueUnseatingNoZsc_TripsAfterBypass');

stCfg.xZscUsed := FALSE;
stCfg.xTorqueUsed := TRUE;
stCfg.xCloseOnTorque := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0
stCmd.xClose := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Closing
fbVlv.xTorqueClose := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // посадка по муфте
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'precondition: closed on torque');
fbVlv.xTorqueClose := FALSE;
fbTime.Advance(tStep := T#2S);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // выбег прошёл (tReverse)
stCmd.xOpen := TRUE;
fbVlv.xTorqueOpen := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);   // t1: Opening с седла, муфта сразу
AssertTrue(Condition := fbVlv.xQOpen, Message := 'precondition: opening from the seat');
FOR iStep := 1 TO 19 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.xQOpen, Message := 'torque ignored within the unseating bypass (1.9 s)');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'no fault within the bypass');
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t1 + 2,0 с
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_TORQUE_TRIP, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'TorqueTrip exactly at the end of the bypass');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'output off');

coUnit.TEST_FINISHED();
