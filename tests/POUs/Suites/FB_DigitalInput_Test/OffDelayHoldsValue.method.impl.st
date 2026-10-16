coUnit.TEST('DigitalInput_OffDelay_HoldsValue');

stCfg.tOffDelay := T#1S;
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);   // t0
AssertTrue(Condition := fbDi.xValue, Message := 'value on');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // t1: сигнал пропал
FOR iStep := 1 TO 9 DO   // t1 + 0,9 с
    fbTime.Advance(tStep := T#100MS);
    fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbDi.xValue, Message := 'value held by off-delay');
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_TIMING_OFF) <> 0,
           Message := 'timing off bit');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // t1 + 1,0 с
AssertFalse(Condition := fbDi.xValue, Message := 'value off after off-delay');

coUnit.TEST_FINISHED();
