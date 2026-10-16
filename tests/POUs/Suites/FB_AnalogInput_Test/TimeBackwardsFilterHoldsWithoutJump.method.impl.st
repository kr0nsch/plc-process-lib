coUnit.TEST('AnalogInput_TimeBackwards_FilterHoldsWithoutJump');

stCfg.tFilter := T#10S;
fbAi(itfTime := fbTime, rIn := 4.0, stCmd := stCmd, stCfg := stCfg);
FOR iStep := 1 TO 50 DO   // 5 с ступени
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 20.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
rBefore := fbAi.rValue_eu;
fbTime.SetNow(ltValue := fbTime.Now() - LTIME#1S);
fbAi(itfTime := fbTime, rIn := 20.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := rBefore, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'no jump on time backwards');
AssertTrue(Condition := F_IsFinite(rIn := fbAi.rValue_eu), Message := 'finite');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 20.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.rValue_eu > rBefore, Message := 'filter continues forward');
AssertTrue(Condition := fbAi.rValue_eu < rBefore + 1.0, Message := 'by one 100 ms step only');

coUnit.TEST_FINISHED();
