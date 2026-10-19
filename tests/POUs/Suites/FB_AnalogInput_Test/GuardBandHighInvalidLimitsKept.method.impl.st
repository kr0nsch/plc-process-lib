coUnit.TEST('AnalogInput_GuardBandHigh_InvalidLimitsKept');

stCfg.rRangeHi_eu := 10.0;
stCfg.astLimit[E_AiAlarm.HH].xEnable := TRUE;
stCfg.astLimit[E_AiAlarm.HH].rSetpoint_eu := 9.5;
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);                 // t0: 5 м
FOR iStep := 1 TO 21 DO                                                              // t1 + 2,0 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 20.9, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertEquals_REAL(Expected := 10.3125, Actual := fbAi.rValue_eu, Delta := 1.0E-4,
                  Message := 'no extrapolation above the 20.5 mA saturation');
AssertFalse(Condition := fbAi.xValid, Message := 'confirmed guard band: invalid for control');
AssertEquals_WORD(Expected := GVL_Const.AI_WRN_OVER_RANGE, Actual := fbAi.stSts.stCommon.wWarning,
                  Message := 'over range warning');
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wFault, Message := 'no fault bits');
AssertTrue(Condition := fbAi.xHH, Message := 'HH kept');

coUnit.TEST_FINISHED();
