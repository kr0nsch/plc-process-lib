coUnit.TEST('DigitalInput_OnDelay_FiltersBounce');

stCfg.tOnDelay := T#500MS;
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // t0
FOR iStep := 1 TO 2 DO                                            // импульс 200 мс
    fbTime.Advance(tStep := T#100MS);
    fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
    xEverOn := xEverOn OR fbDi.xValue;
END_FOR
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_TIMING_ON) <> 0, Message := 'timing on bit');
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_RAW) <> 0, Message := 'raw bit');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
FOR iStep := 1 TO 3 DO                                            // импульс 300 мс
    fbTime.Advance(tStep := T#100MS);
    fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
    xEverOn := xEverOn OR fbDi.xValue;
END_FOR
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
xEverOn := xEverOn OR fbDi.xValue;
AssertFalse(Condition := xEverOn, Message := 'bounce shorter than on-delay ignored');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);   // t1: устойчивый сигнал
FOR iStep := 1 TO 4 DO   // t1 + 0,4 с
    fbTime.Advance(tStep := T#100MS);
    fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertFalse(Condition := fbDi.xValue, Message := 'no value at t1 + 0.4 s');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);   // t1 + 0,5 с
AssertTrue(Condition := fbDi.xValue, Message := 'value exactly at t1 + 0.5 s');
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_VALUE) <> 0, Message := 'value bit');
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_TIMING_ON) = 0, Message := 'timing done');

coUnit.TEST_FINISHED();
