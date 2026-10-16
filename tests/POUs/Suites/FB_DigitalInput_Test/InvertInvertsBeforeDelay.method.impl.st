coUnit.TEST('DigitalInput_Invert_InvertsBeforeDelay');

stCfg.xInvert := TRUE;
stCfg.tOnDelay := T#300MS;
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);   // t0
AssertFalse(Condition := fbDi.xValue, Message := 'inverted: TRUE gives FALSE');
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_RAW) = 0, Message := 'raw after inversion');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // t1: разрыв НЗ-контакта
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_RAW) <> 0, Message := 'raw TRUE at once');
FOR iStep := 1 TO 2 DO   // t1 + 0,2 с
    fbTime.Advance(tStep := T#100MS);
    fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertFalse(Condition := fbDi.xValue, Message := 'on-delay applies to the inverted signal');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // t1 + 0,3 с
AssertTrue(Condition := fbDi.xValue, Message := 'value after on-delay');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
AssertFalse(Condition := fbDi.xValue, Message := 'falling edge without off-delay');

coUnit.TEST_FINISHED();
