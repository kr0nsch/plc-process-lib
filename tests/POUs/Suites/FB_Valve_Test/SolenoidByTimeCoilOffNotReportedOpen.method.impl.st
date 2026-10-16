coUnit.TEST('Valve_SolenoidByTime_CoilOff_NotReportedOpen');

stCfg.eType := E_ValveType.SolenoidEto;
stCfg.xZsoUsed := FALSE;
stCfg.xZscUsed := FALSE;
stCfg.tTravel := T#2S;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 20 DO                                                 // 2 с: открыт по времени
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open by travel time');
AssertTrue(Condition := fbVlv.xQCoil, Message := 'coil holds open');
fbVlv.xPowerOk := FALSE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := fbVlv.xQCoil, Message := 'coil off without power');
AssertFalse(Condition := fbVlv.xOpened, Message := 'spring closes: not reported open');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Unknown, Message := 'Unknown without coil current');
fbVlv.xPowerOk := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := fbVlv.xQCoil, Message := 'Manual stays: coil off after power returns');
AssertFalse(Condition := fbVlv.xOpened, Message := 'still not reported open');
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 20 DO                                                 // снова открыт по времени
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open by travel time again');
fbVlv.xLocal := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := fbVlv.xQCoil, Message := 'coil off in Local');
AssertFalse(Condition := fbVlv.xOpened, Message := 'not reported open in Local');
fbVlv.xLocal := FALSE;
FOR iStep := 1 TO 10 DO                                                 // снова Manual, 1 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    xEverOn := xEverOn OR fbVlv.xQCoil;
END_FOR
AssertTrue(Condition := fbVlv.Mode = E_DeviceMode.Manual, Message := 'back to Manual');
AssertFalse(Condition := xEverOn, Message := 'coil not energized without a command after Local');
AssertFalse(Condition := fbVlv.xOpened, Message := 'not reported open after Local');

coUnit.TEST_FINISHED();
