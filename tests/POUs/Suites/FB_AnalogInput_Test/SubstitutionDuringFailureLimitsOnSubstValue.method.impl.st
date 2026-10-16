coUnit.TEST('AnalogInput_SubstitutionDuringFailure_LimitsOnSubstValue');

stCfg.tFailDelay := T#1S;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.LL, xEnable := TRUE, rSp_eu := 10.0, rHyst_eu := 1.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // Auto: 50
FOR iStep := 1 TO 11 DO   // обрыв t0 + 0,1 … t0 + 1,1 с: отказ подтверждён
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.Fault, Message := 'failure confirmed');
AssertFalse(Condition := fbAi.xLL, Message := 'LL forced off in Auto');
stCmd.stCommon.xSetManual := TRUE;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Manual, Message := 'substitution');
stCmd.rSubstValue_eu := 5.0;   // наладчик проверяет блокировку «сухой ход»
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 5.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'substituted value');
AssertTrue(Condition := fbAi.xValid, Message := 'substituted value is valid');
AssertTrue(Condition := fbAi.xLL, Message := 'LL on substituted value despite the failure');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Failure, Message := 'sensor failure still shown');
itfAlm := fbAi.GetAlarm(uiIndex := E_AiAlarm.LL);
AssertTrue(Condition := itfAlm.State = E_AlarmState.SuppressedByDesign, Message := 'LL alarm suppressed by failure');
stCmd.stCommon.xSetAuto := TRUE;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
AssertFalse(Condition := fbAi.xLL, Message := 'LL forced off again in Auto');
AssertFalse(Condition := fbAi.xValid, Message := 'invalid in Auto with failed sensor');
AssertEquals_REAL(Expected := 50.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'last good value');

coUnit.TEST_FINISHED();
