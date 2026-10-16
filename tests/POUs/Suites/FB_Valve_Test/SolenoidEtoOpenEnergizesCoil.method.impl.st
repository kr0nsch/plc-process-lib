coUnit.TEST('Valve_SolenoidEto_OpenEnergizesCoil');

stCfg.eType := E_ValveType.SolenoidEto;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := fbVlv.xQCoil, Message := 'coil off when closed');
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.xQCoil, Message := 'coil energized to open');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'Opening');
AssertFalse(Condition := fbVlv.xQOpen OR fbVlv.xQClose, Message := 'no motor outputs');
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv.xZsc := FALSE;
    fbVlv.xZso := iStep >= 10;
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open on ZSO');
AssertTrue(Condition := fbVlv.xQCoil, Message := 'coil holds the valve open');
stCmd.xClose := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := fbVlv.xQCoil, Message := 'coil off to close');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closing, Message := 'Closing');

coUnit.TEST_FINISHED();
