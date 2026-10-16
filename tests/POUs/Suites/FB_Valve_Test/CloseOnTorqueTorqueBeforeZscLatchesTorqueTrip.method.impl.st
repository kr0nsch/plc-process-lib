coUnit.TEST('Valve_CloseOnTorque_TorqueBeforeZsc_LatchesTorqueTrip');

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
// муфта раньше ZSC
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Fault, Message := 'torque before ZSC: Fault');
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_TORQUE_TRIP, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'wFault TorqueTrip');
AssertFalse(Condition := fbVlv.xQClose, Message := 'output off');
AssertFalse(Condition := fbVlv.xClosed, Message := 'not reported closed');

stCfg2.xZscUsed := FALSE;
stCfg2.xTorqueUsed := TRUE;
stCfg2.xCloseOnTorque := TRUE;
fbVlv2.xZso := TRUE;
fbVlv2(itfTime := fbTime, stCmd := stCmd2, stRetain := stRetain2, stCfg := stCfg2);
stCmd2.xClose := TRUE;
fbVlv2(itfTime := fbTime, stCmd := stCmd2, stRetain := stRetain2, stCfg := stCfg2);
fbVlv2.xZso := FALSE;
FOR iStep := 1 TO 30 DO                                                 // закрывается 3 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv2(itfTime := fbTime, stCmd := stCmd2, stRetain := stRetain2, stCfg := stCfg2);
END_FOR
fbVlv2.xTorqueClose := TRUE;
fbTime.Advance(tStep := T#100MS);
// без ZSC муфта — окончание закрытия
fbVlv2(itfTime := fbTime, stCmd := stCmd2, stRetain := stRetain2, stCfg := stCfg2);
AssertTrue(Condition := fbVlv2.stSts.eState = E_ValveState.Closed, Message := 'no ZSC: Closed on torque');
AssertEquals_WORD(Expected := 0, Actual := fbVlv2.stSts.stCommon.wFault, Message := 'no ZSC: no torque trip');
AssertFalse(Condition := fbVlv2.xQClose, Message := 'no ZSC: output off');
AssertTrue(Condition := fbVlv2.xClosed, Message := 'no ZSC: xClosed');
fbVlv2.xTorqueClose := FALSE;
FOR iStep := 1 TO 20 DO                                                 // муфта отпустила, 2 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv2(itfTime := fbTime, stCmd := stCmd2, stRetain := stRetain2, stCfg := stCfg2);
END_FOR
AssertTrue(Condition := fbVlv2.stSts.eState = E_ValveState.Closed, Message := 'no ZSC: stays Closed');
AssertEquals_WORD(Expected := 0, Actual := fbVlv2.stSts.stCommon.wFault, Message := 'no ZSC: still no fault');

coUnit.TEST_FINISHED();
