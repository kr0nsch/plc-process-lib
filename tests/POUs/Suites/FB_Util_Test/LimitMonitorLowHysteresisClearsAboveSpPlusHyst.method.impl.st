coUnit.TEST('Util_LimitMonitor_LowHysteresis_ClearsAboveSpPlusHyst');

stLimCfg.xEnable := TRUE;
stLimCfg.rSetpoint_eu := 20.0;
stLimCfg.rHyst_eu := 2.0;
fbLim(rValue_eu := 20.1, xHighLimit := FALSE, stCfg := stLimCfg, itfTime := fbTime);
AssertFalse(Condition := fbLim.xOut, Message := 'above the setpoint: no flag');
fbLim(rValue_eu := 20.0, xHighLimit := FALSE, stCfg := stLimCfg, itfTime := fbTime);
AssertTrue(Condition := fbLim.xOut, Message := 'at the setpoint: flag (inclusive)');
fbLim(rValue_eu := 22.0, xHighLimit := FALSE, stCfg := stLimCfg, itfTime := fbTime);
AssertTrue(Condition := fbLim.xOut, Message := 'at setpoint plus hysteresis: flag held');
fbLim(rValue_eu := 22.1, xHighLimit := FALSE, stCfg := stLimCfg, itfTime := fbTime);
AssertFalse(Condition := fbLim.xOut, Message := 'above setpoint plus hysteresis: flag cleared');
fbLim(rValue_eu := 21.0, xHighLimit := FALSE, stCfg := stLimCfg, itfTime := fbTime);
AssertFalse(Condition := fbLim.xOut, Message := 'inside the band after clearing: stays cleared');

coUnit.TEST_FINISHED();
