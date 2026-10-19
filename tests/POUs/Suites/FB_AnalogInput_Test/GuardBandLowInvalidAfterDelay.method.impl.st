coUnit.TEST('AnalogInput_GuardBandLow_InvalidAfterDelay');

stCfg.rRangeHi_eu := 10.0;
stCfg.astLimit[E_AiAlarm.LL].xEnable := TRUE;
stCfg.astLimit[E_AiAlarm.LL].rSetpoint_eu := 0.5;
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);                 // t0: 5 м
FOR iStep := 1 TO 20 DO                                                              // t1 = t0 + 0,1 с … t1 + 1,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 3.61, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.xValid, Message := 'valid while out of range is unconfirmed (1.9 s)');
AssertEquals_REAL(Expected := -0.125, Actual := fbAi.rValue_eu, Delta := 1.0E-5,
                  Message := 'no extrapolation below the 3.8 mA saturation');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 3.61, stCmd := stCmd, stCfg := stCfg);                  // t1 + 2,0 с
AssertFalse(Condition := fbAi.xValid, Message := 'confirmed guard band: invalid for control');
AssertEquals_REAL(Expected := -0.125, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'value at saturation');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.OutOfSpecification, Message := 'out of specification, not failure');
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wFault, Message := 'no fault bits');
AssertEquals_WORD(Expected := GVL_Const.AI_WRN_UNDER_RANGE, Actual := fbAi.stSts.stCommon.wWarning,
                  Message := 'under range warning');
AssertTrue(Condition := fbAi.xLL, Message := 'LL kept');
FOR iStep := 1 TO 21 DO                                                              // возврат + 2,0 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.xValid, Message := 'valid again after tFailDelay in range');
AssertEquals_REAL(Expected := 5.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'measured value');

coUnit.TEST_FINISHED();
