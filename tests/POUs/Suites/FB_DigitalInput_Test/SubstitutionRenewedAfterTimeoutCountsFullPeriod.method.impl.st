coUnit.TEST('DigitalInput_SubstitutionRenewedAfterTimeout_CountsFullPeriod');

stCfg.tSubstMax := T#30S;
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
stCmd.stCommon.xSetManual := TRUE;
stCmd.xSubstValue := TRUE;
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // t0: подмена
fbTime.Advance(tStep := T#30S);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // t0 + 30 с: снята
AssertTrue(Condition := fbDi.Mode = E_DeviceMode.Auto, Message := 'substitution expired');
stCmd.stCommon.xSetManual := TRUE;
stCmd.xSubstValue := TRUE;
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // t1: новый запрос подмены
AssertTrue(Condition := fbDi.Mode = E_DeviceMode.Manual, Message := 'renewed substitution accepted');
AssertTrue(Condition := fbDi.xValue, Message := 'substituted TRUE');
AssertEquals_UINT(Expected := 30, Actual := fbDi.stSts.uiSubstRemain_s, Message := 'full period again');
fbTime.Advance(tStep := T#600MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // t1 + 0,6 с
AssertEquals_UINT(Expected := 30, Actual := fbDi.stSts.uiSubstRemain_s, Message := '29.4 s rounds up to 30');
fbTime.Advance(tStep := T#29S100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // t1 + 29,7 с
AssertTrue(Condition := fbDi.Mode = E_DeviceMode.Manual, Message := 'still substituted at 29.7 s');
AssertEquals_UINT(Expected := 1, Actual := fbDi.stSts.uiSubstRemain_s, Message := '0.3 s rounds up to 1');
fbTime.Advance(tStep := T#300MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // t1 + 30 с
AssertTrue(Condition := fbDi.Mode = E_DeviceMode.Auto, Message := 'expired again after the full period');
AssertFalse(Condition := fbDi.xValue, Message := 'measured value');

coUnit.TEST_FINISHED();
