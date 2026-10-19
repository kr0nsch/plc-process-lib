coUnit.TEST('Valve_SolenoidWithZso_PowerLoss_NoPositionLostFault');

stCfg.eType := E_ValveType.SolenoidEto;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);   // t0: Closed по ZSC
stCmd.xOpen := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);   // Opening, катушка
fbVlv.xZsc := FALSE;
fbVlv.xZso := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);   // Open по ZSO
AssertTrue(Condition := fbVlv.xQCoil AND fbVlv.stSts.eState = E_ValveState.Open,
           Message := 'precondition: open on ZSO, coil holds');
fbVlv.xPowerOk := FALSE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // нет напряжения
fbVlv.xZso := FALSE;                                                                   // пружина
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    wFltSeen := wFltSeen OR fbVlv.stSts.stCommon.wFault;
END_FOR
fbVlv.xZsc := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // ZSC
AssertEquals_WORD(Expected := 0, Actual := wFltSeen OR fbVlv.stSts.stCommon.wFault,
                  Message := 'no PositionLost without power');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'Closed by ZSC');
AssertFalse(Condition := fbVlv.xQCoil, Message := 'coil off');
fbVlv.xPowerOk := TRUE;
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'no fault after power returns');
AssertFalse(Condition := fbVlv.xQCoil, Message := 'Manual: no output after power returns');

coUnit.TEST_FINISHED();
