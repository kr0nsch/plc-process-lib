coUnit.TEST('DigitalInput_SubstitutionTimeout_ReturnsToAuto');

stCfg.tSubstMax := T#30S;
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
stCmd.stCommon.xSetManual := TRUE;
stCmd.xSubstValue := TRUE;
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // t0: подмена
AssertEquals_UINT(Expected := 30, Actual := fbDi.stSts.uiSubstRemain_s, Message := '30 s remain at start');
FOR iStep := 1 TO 29 DO   // t0 + 29 с
    fbTime.Advance(tStep := T#1000MS);
    fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbDi.Mode = E_DeviceMode.Manual, Message := 'still substituted');
AssertTrue(Condition := fbDi.xValue, Message := 'substituted TRUE');
AssertEquals_UINT(Expected := 1, Actual := fbDi.stSts.uiSubstRemain_s, Message := '1 s remains');
fbTime.Advance(tStep := T#1000MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // t0 + 30 с
AssertTrue(Condition := fbDi.Mode = E_DeviceMode.Auto, Message := 'back to measurement');
AssertTrue(Condition := fbDi.stSts.stCommon.eCmdResult = E_CmdResult.SubstExpired, Message := 'SubstExpired');
AssertFalse(Condition := fbDi.xValue, Message := 'measured value');
AssertEquals_UINT(Expected := 0, Actual := fbDi.stSts.uiSubstRemain_s, Message := 'no remaining time');

coUnit.TEST_FINISHED();
