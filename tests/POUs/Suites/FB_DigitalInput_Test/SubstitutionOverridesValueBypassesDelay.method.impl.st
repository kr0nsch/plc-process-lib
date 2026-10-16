coUnit.TEST('DigitalInput_Substitution_OverridesValueBypassesDelay');

stCfg.tOnDelay := T#5S;
stCfg.tOffDelay := T#5S;
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
AssertFalse(Condition := stCmd.xSubstValue, Message := 'tracking in Auto');
stCmd.stCommon.xSetManual := TRUE;
stCmd.xSubstValue := TRUE;
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbDi.Mode = E_DeviceMode.Manual, Message := 'substitution mode');
AssertTrue(Condition := fbDi.xValue, Message := 'substituted value without delay');
AssertTrue(Condition := fbDi.xValid, Message := 'substituted value valid');
AssertTrue(Condition := fbDi.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction');
stCmd.xSubstValue := FALSE;
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
AssertFalse(Condition := fbDi.xValue, Message := 'substitution follows the operator, not the input');
stCmd.stCommon.xSetAuto := TRUE;
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbDi.Mode = E_DeviceMode.Auto, Message := 'measurement again');

coUnit.TEST_FINISHED();
