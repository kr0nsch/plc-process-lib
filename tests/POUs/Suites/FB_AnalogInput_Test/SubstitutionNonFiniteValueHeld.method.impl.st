coUnit.TEST('AnalogInput_SubstitutionNonFinite_ValueHeld');

fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
stCmd.stCommon.xSetManual := TRUE;
stCmd.rSubstValue_eu := 42.0;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 42.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'substituted 42');
uBits.dwValue := 16#7FC00000;
stCmd.rSubstValue_eu := uBits.rValue;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 42.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'NaN substitution ignored');
AssertTrue(Condition := F_IsFinite(rIn := fbAi.rValue_eu), Message := 'value finite');

coUnit.TEST_FINISHED();
