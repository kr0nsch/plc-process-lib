coUnit.TEST('Device_BeginCycle_DtZeroOnFirstCallThenFromTimeSource');

fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_LTIME(Expected := LTIME#0S, Actual := fbDev.ltDtSeen, Message := 'dt = 0 in the first call');
fbTime.Advance(tStep := T#250MS);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_LTIME(Expected := LTIME#250MS, Actual := fbDev.ltDtSeen, Message := 'dt = step of the time source');
fbTime.SetNow(ltValue := LTIME#30M);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_LTIME(Expected := LTIME#0S, Actual := fbDev.ltDtSeen, Message := 'time backwards: dt = 0');
fbTime.Advance(tStep := T#100MS);
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_LTIME(Expected := LTIME#100MS, Actual := fbDev.ltDtSeen, Message := 'dt after time backwards');

coUnit.TEST_FINISHED();
