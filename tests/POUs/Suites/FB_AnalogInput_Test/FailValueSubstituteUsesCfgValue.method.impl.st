coUnit.TEST('AnalogInput_FailValueSubstitute_UsesCfgValue');

stCfg.eFailValue := E_AiFailValue.Substitute;
stCfg.rFailValue_eu := 99.0;
stCfg.tFailDelay := T#1S;
fbAi(itfTime := fbTime, rIn := 8.0, stCmd := stCmd, stCfg := stCfg);   // t0: 25
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);   // t1 = t0 + 0,1 с: обрыв
FOR iStep := 1 TO 9 DO   // t1 + 0,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertEquals_REAL(Expected := 25.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'last good while pending');
AssertTrue(Condition := fbAi.xValid, Message := 'valid while pending');
FOR iStep := 1 TO 1 DO   // t1 + 1,0 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.Fault, Message := 'failure confirmed');
AssertEquals_REAL(Expected := 99.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'substitute value from Cfg');
AssertFalse(Condition := fbAi.xValid, Message := 'substitute value is not valid');

coUnit.TEST_FINISHED();
