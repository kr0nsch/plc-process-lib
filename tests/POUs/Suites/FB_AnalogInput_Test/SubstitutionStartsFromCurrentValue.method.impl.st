coUnit.TEST('AnalogInput_Substitution_StartsFromCurrentValue');

stCfg.rRangeLo_eu := 2.0;
stCfg.rRangeHi_eu := 12.0;
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // Auto: 7,0
AssertEquals_REAL(Expected := 7.0, Actual := stCmd.rSubstValue_eu, Delta := 1.0E-5, Message := 'tracking in Auto');
stCmd.stCommon.xSetManual := TRUE;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 20.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Manual, Message := 'substitution');
AssertEquals_REAL(Expected := 7.0, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'bumpless: starts from 7.0');
AssertEquals_REAL(Expected := 7.0, Actual := stCmd.rSubstValue_eu, Delta := 1.0E-5,
                  Message := 'operator owns the value');

coUnit.TEST_FINISHED();
