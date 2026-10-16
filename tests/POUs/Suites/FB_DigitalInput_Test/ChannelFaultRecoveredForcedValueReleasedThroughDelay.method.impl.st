coUnit.TEST('DigitalInput_ChannelFaultRecovered_ForcedValueReleasedThroughDelay');

stCfg.eFailValue := E_DiFailValue.ForceTrue;
stCfg.tOnDelay := T#2S;
stCfg.tOffDelay := T#3S;
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // норма: FALSE
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, xChannelFault := TRUE, stCmd := stCmd, stCfg := stCfg);   // отказ канала
AssertTrue(Condition := fbDi.xValue, Message := 'forced TRUE on channel fault');
// 1) канал исправен, датчик сработал
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, xChannelFault := FALSE, stCmd := stCmd, stCfg := stCfg);
xEverOff := NOT fbDi.xValue;
AssertTrue(Condition := fbDi.xValid, Message := 'valid after recovery');
FOR iStep := 1 TO 25 DO   // 2,5 с: дольше tOnDelay
    fbTime.Advance(tStep := T#100MS);
    fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
    xEverOff := xEverOff OR NOT fbDi.xValue;
END_FOR
AssertFalse(Condition := xEverOff, Message := 'no FALSE gap after recovery when the sensor is tripped');
// 2) датчик в норме дольше tOffDelay, затем отказ и возврат с датчиком в норме
FOR iStep := 1 TO 31 DO   // 3,1 с
    fbTime.Advance(tStep := T#100MS);
    fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertFalse(Condition := fbDi.xValue, Message := 'value off before the second fault');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, xChannelFault := TRUE, stCmd := stCmd, stCfg := stCfg);
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, xChannelFault := FALSE, stCmd := stCmd, stCfg := stCfg);   // tr: канал исправен
AssertTrue(Condition := fbDi.xValue, Message := 'forced value kept at recovery');
FOR iStep := 1 TO 29 DO   // tr + 2,9 с
    fbTime.Advance(tStep := T#100MS);
    fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbDi.xValue, Message := 'released only through tOffDelay');
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_TIMING_OFF) <> 0, Message := 'timing off');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // tr + 3,0 с
AssertFalse(Condition := fbDi.xValue, Message := 'off exactly tOffDelay after recovery');

coUnit.TEST_FINISHED();
