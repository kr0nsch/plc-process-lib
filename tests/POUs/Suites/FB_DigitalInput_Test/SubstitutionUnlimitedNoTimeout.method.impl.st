coUnit.TEST('DigitalInput_SubstitutionUnlimited_NoTimeout');

stCfg.tSubstMax := T#0S;
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
stCmd.stCommon.xSetManual := TRUE;
stCmd.xSubstValue := TRUE;
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);                 // подмена
AssertTrue(Condition := fbDi.Mode = E_DeviceMode.Manual, Message := 'substituted');
FOR iStep := 1 TO 24 DO
    fbTime.Advance(tStep := T#1H);
    fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
    xEverAuto := xEverAuto OR fbDi.Mode = E_DeviceMode.Auto;
END_FOR
AssertFalse(Condition := xEverAuto, Message := 'never returned to Auto in 24 h');
AssertTrue(Condition := fbDi.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'no SubstExpired');
AssertTrue(Condition := fbDi.xValue, Message := 'substituted TRUE');
AssertEquals_UINT(Expected := 0, Actual := fbDi.stSts.uiSubstRemain_s, Message := 'no remaining time without a limit');

coUnit.TEST_FINISHED();
