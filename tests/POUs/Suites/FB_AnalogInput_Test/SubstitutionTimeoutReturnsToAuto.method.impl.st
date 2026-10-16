coUnit.TEST('AnalogInput_SubstitutionTimeout_ReturnsToAuto');

stCfg.tSubstMax := T#1M;
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // Auto: 50
stCmd.stCommon.xSetManual := TRUE;
stCmd.rSubstValue_eu := 42.0;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t0: подмена
AssertEquals_UINT(Expected := 60, Actual := fbAi.stSts.uiSubstRemain_s, Message := '60 s remain at start');
FOR iStep := 1 TO 59 DO   // t0 + 59 с
    fbTime.Advance(tStep := T#1000MS);
    fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Manual, Message := 'still substituted at 59 s');
AssertEquals_REAL(Expected := 42.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'substituted value');
AssertEquals_UINT(Expected := 1, Actual := fbAi.stSts.uiSubstRemain_s, Message := '1 s remains');
uiSeq := fbAi.stSts.stCommon.uiCmdSeq;
fbTime.Advance(tStep := T#1000MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t0 + 60 с
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Auto, Message := 'back to measurement');
AssertTrue(Condition := fbAi.stSts.stCommon.eCmdResult = E_CmdResult.SubstExpired, Message := 'SubstExpired');
AssertEquals_UINT(Expected := uiSeq + 1, Actual := fbAi.stSts.stCommon.uiCmdSeq, Message := 'counted as one result');
AssertEquals_REAL(Expected := 50.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'measured in the same call');
AssertEquals_UINT(Expected := 0, Actual := fbAi.stSts.uiSubstRemain_s, Message := 'no remaining time');

coUnit.TEST_FINISHED();
