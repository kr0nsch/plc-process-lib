coUnit.TEST('AnalogInput_SubstitutionRenewedAfterTimeout_CountsFullPeriod');

stCfg.tSubstMax := T#1M;
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // Auto: 50
stCmd.stCommon.xSetManual := TRUE;
stCmd.rSubstValue_eu := 42.0;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t0: подмена
fbTime.Advance(tStep := T#60S);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t0 + 60 с: снята
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Auto, Message := 'substitution expired');
AssertTrue(Condition := fbAi.stSts.stCommon.eCmdResult = E_CmdResult.SubstExpired, Message := 'SubstExpired');
stCmd.stCommon.xSetManual := TRUE;
stCmd.rSubstValue_eu := 42.0;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t1: новый запрос подмены
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Manual, Message := 'renewed substitution accepted');
AssertTrue(Condition := fbAi.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'Accepted');
AssertEquals_REAL(Expected := 42.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'substituted value');
AssertEquals_UINT(Expected := 60, Actual := fbAi.stSts.uiSubstRemain_s, Message := 'full period again');
fbTime.Advance(tStep := T#600MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t1 + 0,6 с
AssertEquals_UINT(Expected := 60, Actual := fbAi.stSts.uiSubstRemain_s, Message := '59.4 s rounds up to 60');
fbTime.Advance(tStep := T#58S100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t1 + 58,7 с
AssertEquals_UINT(Expected := 2, Actual := fbAi.stSts.uiSubstRemain_s, Message := '1.3 s rounds up to 2');
fbTime.Advance(tStep := T#1S200MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t1 + 59,9 с
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Manual, Message := 'still substituted at 59.9 s');
AssertEquals_UINT(Expected := 1, Actual := fbAi.stSts.uiSubstRemain_s, Message := '0.1 s rounds up to 1');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t1 + 60 с
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Auto, Message := 'expired again after the full period');
AssertEquals_UINT(Expected := 0, Actual := fbAi.stSts.uiSubstRemain_s, Message := 'no remaining time');

coUnit.TEST_FINISHED();
