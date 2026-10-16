coUnit.TEST('AnalogInput_InvalidRangeAtStartup_CheckFunctionSafeValue');

stCfg.rRangeLo_eu := 10.0;
stCfg.rRangeHi_eu := 10.0;
fbAi(itfTime := fbTime, rIn := 20.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_RANGE, Actual := fbAi.stSts.stCommon.wCfgErr, Message := 'range bit');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction');
AssertEquals_REAL(Expected := 0.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'safe value');
AssertEquals_REAL(Expected := 0.0, Actual := fbAi.rValue_pct, Delta := 0.0, Message := 'safe percent');
AssertFalse(Condition := fbAi.xValid, Message := 'invalid');
AssertFalse(Condition := fbAi.xHH OR fbAi.xH OR fbAi.xL OR fbAi.xLL, Message := 'limit flags false');
AssertFalse(Condition := fbAi.Available, Message := 'not available');
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Auto, Message := 'Auto from the first call');
AssertTrue(Condition := fbAi.stSts.stCommon.eDevType = E_DeviceType.AnalogInput, Message := 'device type');

coUnit.TEST_FINISHED();
