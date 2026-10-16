coUnit.TEST('Util_LimitMonitor_NonFiniteValue_KeepsState');

stLimCfg.xEnable := TRUE;
stLimCfg.rSetpoint_eu := 80.0;
stLimCfg.rHyst_eu := 2.0;
fbLim(rValue_eu := 90.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertTrue(Condition := fbLim.xOut, Message := 'flag set at 90');
uBits.dwValue := 16#7FC00000;
fbLim(rValue_eu := uBits.rValue, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertTrue(Condition := fbLim.xOut, Message := 'NaN keeps the flag set');
uBits.dwValue := 16#FF800000;
fbLim(rValue_eu := uBits.rValue, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertTrue(Condition := fbLim.xOut, Message := '-Inf keeps the flag set');
fbLim(rValue_eu := 10.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertFalse(Condition := fbLim.xOut, Message := 'flag cleared at 10');
uBits.dwValue := 16#7F800000;
fbLim(rValue_eu := uBits.rValue, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertFalse(Condition := fbLim.xOut, Message := '+Inf keeps the flag cleared');
fbLim(rValue_eu := 1.0E31, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertFalse(Condition := fbLim.xOut, Message := 'value above REAL_SANE_MAX keeps the flag cleared');

coUnit.TEST_FINISHED();
