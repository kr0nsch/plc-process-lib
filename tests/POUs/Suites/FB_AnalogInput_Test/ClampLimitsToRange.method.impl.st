coUnit.TEST('AnalogInput_Clamp_LimitsToRange');

fbAi(itfTime := fbTime, rIn := 20.4, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 102.5, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'extrapolated by default');
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wWarning, Message := 'no warning without clamp');
stCfg.xClamp := TRUE;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 20.4, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 100.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'clamped to range high');
AssertEquals_WORD(Expected := GVL_Const.AI_WRN_CLAMPED, Actual := fbAi.stSts.stCommon.wWarning, Message := 'clamped');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Good, Message := 'clamping is a warning only');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 3.9, stCmd := stCmd, stCfg := stCfg);
AssertEquals_REAL(Expected := 0.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'clamped to range low');
AssertEquals_WORD(Expected := GVL_Const.AI_WRN_CLAMPED, Actual := fbAi.stSts.stCommon.wWarning,
                  Message := 'clamped low');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wWarning, Message := 'warning cleared inside range');

coUnit.TEST_FINISHED();
