coUnit.TEST('Util_LimitMonitor_HighHysteresis_ClearsBelowSpMinusHyst');

stLimCfg.xEnable := TRUE;
stLimCfg.rSetpoint_eu := 80.0;
stLimCfg.rHyst_eu := 5.0;
fbLim(rValue_eu := 79.9, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertFalse(Condition := fbLim.xOut, Message := 'below the setpoint: no flag');
fbLim(rValue_eu := 80.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertTrue(Condition := fbLim.xOut, Message := 'at the setpoint: flag (inclusive)');
fbLim(rValue_eu := 75.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertTrue(Condition := fbLim.xOut, Message := 'at setpoint minus hysteresis: flag held');
fbLim(rValue_eu := 74.9, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertFalse(Condition := fbLim.xOut, Message := 'below setpoint minus hysteresis: flag cleared');
fbLim(rValue_eu := 79.0, xHighLimit := TRUE, stCfg := stLimCfg, itfTime := fbTime);
AssertFalse(Condition := fbLim.xOut OR fbLim.xRaw, Message := 'inside the band after clearing: stays cleared');

coUnit.TEST_FINISHED();
