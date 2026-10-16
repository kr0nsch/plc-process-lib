coUnit.TEST('Valve_PositionByTime_LostInLocal_AutoDrivesAgain');

stCfg.xZsoUsed := FALSE;
stCfg.xZscUsed := FALSE;
stCfg.tTravel := T#10S;
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbVlv.xAutoOpen := TRUE;
// t0: Auto ведёт к цели
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.xQOpen, Message := 'Auto opens');
FOR iStep := 1 TO 100 DO                                                // t0 + 10,0 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open by travel time');
AssertTrue(Condition := fbVlv.xOpened, Message := 'xOpened by time');
fbVlv.xLocal := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.Mode = E_DeviceMode.Local, Message := 'Local');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Unknown, Message := 'position by time lost in Local');
AssertFalse(Condition := fbVlv.xOpened, Message := 'not reported open in Local');
AssertEquals_WORD(Expected := GVL_Const.VLV_WRN_POSITION_UNKNOWN,
                  Actual := fbVlv.stSts.stCommon.wWarning AND GVL_Const.VLV_WRN_POSITION_UNKNOWN,
                  Message := 'POSITION_UNKNOWN warning');
FOR iStep := 1 TO 50 DO                                                 // 5 с в Local
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
fbVlv.xLocal := FALSE;
fbTime.Advance(tStep := T#100MS);
// t1: снова Auto
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.Mode = E_DeviceMode.Auto, Message := 'back to Auto');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'Auto drives to target again');
AssertTrue(Condition := fbVlv.xQOpen, Message := 'open contactor on');
FOR iStep := 1 TO 99 DO                                                 // t1 + 9,9 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'Opening at t1 + 9.9 s');
fbTime.Advance(tStep := T#100MS);
// t1 + 10,0 с
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open by travel time again');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'no fault');

coUnit.TEST_FINISHED();
