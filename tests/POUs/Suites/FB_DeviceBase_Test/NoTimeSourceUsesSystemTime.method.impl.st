coUnit.TEST('Device_NoTimeSource_UsesSystemTime');

fbDev(stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbDev(stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.itfTimeAct <> 0, Message := 'built-in system time source used');
AssertTrue(Condition := fbDev.ltNow > LTIME#0S, Message := 'system time above zero');
AssertTrue(Condition := fbDev.ltDtSeen < LTIME#1S, Message := 'dt between two adjacent calls below 1 s');

coUnit.TEST_FINISHED();
