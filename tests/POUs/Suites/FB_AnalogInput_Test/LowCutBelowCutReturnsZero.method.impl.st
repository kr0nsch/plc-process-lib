coUnit.TEST('AnalogInput_LowCut_BelowCut_ReturnsZero');

stCfg.xSqrt := TRUE;
stCfg.rLowCut_pct := 5.0;
fbAi(itfTime := fbTime, rIn := 4.032, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 0.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'below cut gives zero');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.AI_STS_LOW_CUT) <> 0, Message := 'low cut bit');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 4.16, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 9.999995, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'above cut: 10 % flow');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.AI_STS_LOW_CUT) = 0, Message := 'no low cut bit');
stCfg.xSqrt := FALSE;
stCfg.rLowCut_pct := 3.0;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 4.4, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 0.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'low cut without sqrt');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.AI_STS_LOW_CUT) <> 0, Message := 'bit without sqrt');
stCfg.rLowCut_pct := 12.5;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 6.0, stCmd := stCmd, stCfg := stCfg);   // ровно 12,5 % при отсечке 12,5 %
AssertEquals_REAL(Expected := 12.5, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'value at the cut is kept');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.AI_STS_LOW_CUT) = 0, Message := 'no bit at the cut');

coUnit.TEST_FINISHED();
