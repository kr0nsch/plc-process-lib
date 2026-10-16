coUnit.TEST('AnalogInput_OutOfService_HoldsValueInvalid');

SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.H, xEnable := TRUE, rSp_eu := 40.0, rHyst_eu := 1.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // Auto: 50, H
AssertTrue(Condition := fbAi.xH, Message := 'H before OOS');
stCmd.stCommon.xSetOos := TRUE;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.OutOfService, Message := 'out of service');
AssertEquals_REAL(Expected := 50.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'value held');
AssertFalse(Condition := fbAi.xValid, Message := 'invalid in OOS');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction');
AssertFalse(Condition := fbAi.xH, Message := 'limits off in OOS');
itfAlm := fbAi.GetAlarm(uiIndex := E_AiAlarm.H);
AssertTrue(Condition := itfAlm.State = E_AlarmState.OutOfService, Message := 'H slot out of service');
itfAlm := fbAi.GetAlarm(uiIndex := E_AiAlarm.Failure);
AssertTrue(Condition := itfAlm.State = E_AlarmState.OutOfService, Message := 'failure slot out of service');
FOR iStep := 1 TO 30 DO   // обрыв в OOS, 3 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.Status = E_Ne107Status.CheckFunction, Message := 'no failure in OOS');
stCmd.stCommon.xSetAuto := TRUE;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Auto, Message := 'back in service');
AssertEquals_REAL(Expected := 75.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'measured after OOS');
AssertTrue(Condition := fbAi.xValid, Message := 'valid after OOS');

coUnit.TEST_FINISHED();
