coUnit.TEST('Valve_TorqueMidTravel_LatchesTorqueTrip');

stCfg.xTorqueUsed := TRUE;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
FOR iStep := 1 TO 30 DO                                                 // открывается 3 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
fbVlv.xTorqueOpen := TRUE;
fbTime.Advance(tStep := T#100MS);
// муфта раньше концевика
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Fault, Message := 'Fault on torque mid travel');
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_TORQUE_TRIP, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'wFault TorqueTrip');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'output off');
AssertEquals_WORD(Expected := GVL_Const.VLV_STS_TORQUE,
                  Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.VLV_STS_TORQUE, Message := 'TORQUE bit');
fbVlv.xTorqueOpen := FALSE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_TORQUE_TRIP, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'latched after the switch released');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.VLV_STS_TORQUE,
                  Message := 'TORQUE bit follows the switch');
stCmd.stCommon.xReset := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'cleared by Reset');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Intermediate, Message := 'Intermediate after Reset');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'no restart in Manual');

coUnit.TEST_FINISHED();
