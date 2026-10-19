coUnit.TEST('Valve_InterlockWithBothLimits_DrivesSafe');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbVlv.xAutoOpen := TRUE;
fbVlv.xZso := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Open по ZSO
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'precondition: Open');
fbVlv.xZsc := TRUE;                                                                    // замыкание в цепи ZSC
FOR iStep := 1 TO 6 DO                                                               // фильтр 0,5 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_BOTH_LIMITS, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'precondition: BothLimits');
AssertFalse(Condition := fbVlv.xQClose, Message := 'no motion before the interlock');
fbVlv.wInterlock := 16#0001;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t1: блокировка
AssertTrue(Condition := fbVlv.xQClose, Message := 'interlock drives to the safe position despite BothLimits');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'open output off');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Fault, Message := 'state stays Fault');
AssertEquals_WORD(Expected := GVL_Const.VLV_STS_INTERLOCKED OR GVL_Const.VLV_STS_CLOSING,
                  Actual := fbVlv.stSts.stCommon.wStatus
                      AND (GVL_Const.VLV_STS_INTERLOCKED OR GVL_Const.VLV_STS_CLOSING),
                  Message := 'INTERLOCKED and CLOSING bits');
xCloseOn := TRUE;
FOR iStep := 1 TO 599 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    xCloseOn := xCloseOn AND fbVlv.xQClose;
    xBoth := xBoth OR (fbVlv.xQOpen AND fbVlv.xQClose);
END_FOR
AssertTrue(Condition := xCloseOn, Message := 'ZSC not trusted: still closing at t1 + 59.9 s');
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t1 + 60 с = tTravel
AssertFalse(Condition := fbVlv.xQClose, Message := 'safe move ends by tTravel');
AssertFalse(Condition := xBoth, Message := 'never both outputs');
fbTime.Advance(tStep := T#1S);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := fbVlv.xQClose, Message := 'not repeated while the interlock stays');
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_BOTH_LIMITS, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'fault still shown');

coUnit.TEST_FINISHED();
