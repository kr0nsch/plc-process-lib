coUnit.TEST('AnalogInput_SubstitutionUnlimited_NoTimeout');

stCfg.tSubstMax := T#0S;
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
stCmd.stCommon.xSetManual := TRUE;
stCmd.rSubstValue_eu := 42.0;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);                  // подмена
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Manual, Message := 'substituted');
FOR iStep := 1 TO 24 DO
    fbTime.Advance(tStep := T#1H);
    fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
    xEverAuto := xEverAuto OR fbAi.Mode = E_DeviceMode.Auto;
END_FOR
AssertFalse(Condition := xEverAuto, Message := 'never returned to Auto in 24 h');
AssertTrue(Condition := fbAi.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'no SubstExpired');
AssertEquals_REAL(Expected := 42.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'substituted value');
AssertEquals_UINT(Expected := 0, Actual := fbAi.stSts.uiSubstRemain_s, Message := 'no remaining time without a limit');

coUnit.TEST_FINISHED();
