coUnit.TEST('Valve_InterlockAfterPositionLost_DrivesSafe');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbVlv.xAutoOpen := TRUE;
fbVlv.xZso := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Open по ZSO
fbVlv.xZso := FALSE;                                                                   // обрыв ZSO
FOR iStep := 1 TO 6 DO                                                               // фильтр 0,5 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_POSITION_LOST, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'precondition: PositionLost latched');
AssertFalse(Condition := fbVlv.xQOpen OR fbVlv.xQClose, Message := 'no motion with the fault alone');
fbVlv.wInterlock := 16#0001;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t1: блокировка
AssertTrue(Condition := fbVlv.xQClose, Message := 'interlock drives Closed despite PositionLost');
FOR iStep := 1 TO 30 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.xQClose, Message := 'still closing before ZSC');
fbVlv.xZsc := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // ZSC
AssertFalse(Condition := fbVlv.xQClose, Message := 'safe move ends on a consistent ZSC');
AssertTrue(Condition := fbVlv.xClosed, Message := 'position Closed shown');
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_POSITION_LOST, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'fault latched until Reset');
stCmd.stCommon.xReset := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'cleared by Reset');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'Closed after Reset');
AssertFalse(Condition := fbVlv.xQOpen OR fbVlv.xQClose, Message := 'no motion: already in the safe position');

coUnit.TEST_FINISHED();
