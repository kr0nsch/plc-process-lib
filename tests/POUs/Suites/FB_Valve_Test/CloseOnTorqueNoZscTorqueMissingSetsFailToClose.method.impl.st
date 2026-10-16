coUnit.TEST('Valve_CloseOnTorqueNoZsc_TorqueMissing_SetsFailToClose');

stCfg.xZscUsed := FALSE;
stCfg.xTorqueUsed := TRUE;
stCfg.xCloseOnTorque := TRUE;
stCfg.tTravel := T#10S;
fbVlv.xZso := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xClose := TRUE;
// t0: Closing
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZso := FALSE;
FOR iStep := 1 TO 99 DO                                                 // до t0 + 9,9 с, муфты нет
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closing, Message := 'still closing at t0 + 9.9 s');
AssertTrue(Condition := fbVlv.xQClose, Message := 'close output held until torque');
fbTime.Advance(tStep := T#100MS);
// t0 + 10,0 с
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Fault, Message := 'Fault at tTravel, not closed by time');
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_FAIL_TO_CLOSE, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'wFault FailToClose');
AssertFalse(Condition := fbVlv.xQClose, Message := 'output off on timeout');
AssertFalse(Condition := fbVlv.xClosed, Message := 'not reported closed');

coUnit.TEST_FINISHED();
