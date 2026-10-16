coUnit.TEST('AnalogInput_RawRangeUnset_CfgErrBit8');

stCfg.eInput := E_AiInputType.Raw;
fbAi(itfTime := fbTime, rIn := 5000.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_RAW_RANGE, Actual := fbAi.stSts.stCommon.wCfgErr,
                  Message := 'only bit 8: raw range not set');
AssertEquals_WORD(Expected := 16#0100, Actual := GVL_Const.AI_CFG_RAW_RANGE, Message := 'bit 8 mask');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction');
AssertEquals_REAL(Expected := 0.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'safe value 0.0');
AssertFalse(Condition := fbAi.xValid, Message := 'value invalid without valid Cfg');
AssertFalse(Condition := fbAi.Available, Message := 'not available');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_CFG_ERROR) <> 0, Message := 'cfg error bit');
stCfg.rRawHi_cnt := 10000.0;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 5000.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wCfgErr, Message := 'Cfg accepted after raw range set');
AssertEquals_REAL(Expected := 50.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := '5000 of 0..10000 counts');
AssertTrue(Condition := fbAi.Status = E_Ne107Status.Good, Message := 'good after fix');

coUnit.TEST_FINISHED();
