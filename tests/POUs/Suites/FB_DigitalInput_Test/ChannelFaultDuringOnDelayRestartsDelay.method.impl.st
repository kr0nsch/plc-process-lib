coUnit.TEST('DigitalInput_ChannelFaultDuringOnDelay_RestartsDelay');

stCfg.tOnDelay := T#1S;
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);   // t0: фронт
FOR iStep := 1 TO 5 DO   // t0 + 0,5 с
    fbTime.Advance(tStep := T#100MS);
    fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_TIMING_ON) <> 0, Message := 'timing on');
FOR iStep := 1 TO 2 DO   // отказ канала: t0 + 0,6 … t0 + 0,7 с
    fbTime.Advance(tStep := T#100MS);
    fbDi(itfTime := fbTime, xIn := TRUE, xChannelFault := TRUE, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_TIMING_ON) = 0,
           Message := 'no timing bit during channel fault');
AssertFalse(Condition := fbDi.xValue, Message := 'value before the fault held');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, xChannelFault := FALSE, stCmd := stCmd, stCfg := stCfg);   // tr = t0 + 0,8 с
xEverOn := fbDi.xValue;
FOR iStep := 1 TO 9 DO   // tr + 0,9 с (t0 + 1,7 с)
    fbTime.Advance(tStep := T#100MS);
    fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
    xEverOn := xEverOn OR fbDi.xValue;
END_FOR
AssertFalse(Condition := xEverOn, Message := 'on-delay restarted at recovery, not counted from t0');
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_TIMING_ON) <> 0,
           Message := 'timing on again after recovery');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);   // tr + 1,0 с
AssertTrue(Condition := fbDi.xValue, Message := 'value exactly tOnDelay after recovery');

coUnit.TEST_FINISHED();
