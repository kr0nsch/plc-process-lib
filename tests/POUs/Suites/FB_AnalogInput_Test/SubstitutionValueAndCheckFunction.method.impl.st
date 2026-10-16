coUnit.TEST('AnalogInput_Substitution_ValueAndCheckFunction');

SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.H, xEnable := TRUE, rSp_eu := 80.0, rHyst_eu := 2.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // Auto: 50
stCmd.stCommon.xSetManual := TRUE;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Manual, Message := 'substitution mode');
AssertTrue(Condition := fbAi.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'command accepted');
AssertFalse(Condition := stCmd.stCommon.xSetManual, Message := 'command bit cleared');
stCmd.rSubstValue_eu := 85.0;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 85.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'substituted value');
AssertTrue(Condition := fbAi.xValid, Message := 'substituted value is valid');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction in substitution');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_MODE_MANUAL) <> 0, Message := 'manual bit');
AssertTrue(Condition := fbAi.xH, Message := 'limits on substituted value');
stCmd.stCommon.xSetAuto := TRUE;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Auto, Message := 'measurement again');
AssertEquals_REAL(Expected := 50.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'measured value');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Good, Message := 'good again');

coUnit.TEST_FINISHED();
