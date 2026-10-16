coUnit.TEST('DigitalInput_ChannelFault_ForceFalse');

stCfg.eFailValue := E_DiFailValue.ForceFalse;
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbDi.xValue, Message := 'value on');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, xChannelFault := TRUE, stCmd := stCmd, stCfg := stCfg);
AssertFalse(Condition := fbDi.xValue, Message := 'forced FALSE on channel fault');
AssertFalse(Condition := fbDi.xValid, Message := 'invalid');

coUnit.TEST_FINISHED();
