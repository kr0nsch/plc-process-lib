coUnit.TEST('Valve_AutoToManual_Bumpless');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbVlv.xAutoOpen := TRUE;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'Auto opens on first call');
fbVlv.xZsc := FALSE;
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
stCmd.stCommon.xSetManual := TRUE;
fbVlv.xAutoOpen := FALSE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.Mode = E_DeviceMode.Manual, Message := 'Manual');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'keeps direction');
AssertTrue(Condition := fbVlv.xQOpen, Message := 'output kept');
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv.xZso := iStep >= 10;
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open on ZSO');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'output off');

coUnit.TEST_FINISHED();
