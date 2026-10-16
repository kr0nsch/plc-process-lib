coUnit.TEST('DigitalInput_InvertFromFirstValidCfg_NoFalseValue');

stCfg.xInvert := TRUE;
stCfg.tOnDelay := T#2S;
stCfg.tOffDelay := T#2S;
uEnum.iValue := 5;
stCfg.eFailValue := uEnum.eDiFailValue;   // Cfg испорчена с первого вызова
fbDiA(itfTime := fbTime, xIn := TRUE, stCmd := stCmdA, stCfg := stCfg);
fbDiB(itfTime := fbTime, xIn := FALSE, stCmd := stCmdB, stCfg := stCfg);
fbTime.Advance(tStep := T#1S);
fbDiA(itfTime := fbTime, xIn := TRUE, stCmd := stCmdA, stCfg := stCfg);
fbDiB(itfTime := fbTime, xIn := FALSE, stCmd := stCmdB, stCfg := stCfg);
AssertFalse(Condition := fbDiA.xValid, Message := 'A invalid without Cfg');
AssertFalse(Condition := fbDiB.xValue, Message := 'B safe value FALSE without Cfg');
stCfg.eFailValue := E_DiFailValue.ForceTrue;   // Cfg исправлена
fbTime.Advance(tStep := T#100MS);
fbDiA(itfTime := fbTime, xIn := TRUE, stCmd := stCmdA, stCfg := stCfg);
fbDiB(itfTime := fbTime, xIn := FALSE, stCmd := stCmdB, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbDiA.stSts.stCommon.wCfgErr, Message := 'Cfg accepted');
AssertTrue(Condition := fbDiA.xValid, Message := 'A valid');
AssertFalse(Condition := fbDiA.xValue, Message := 'A: closed NC contact is FALSE at once, no false trip');
AssertTrue(Condition := (fbDiA.stSts.stCommon.wStatus AND GVL_Const.DI_STS_TIMING_OFF) = 0,
           Message := 'A: no off-delay timing');
AssertTrue(Condition := fbDiB.xValid, Message := 'B valid');
AssertTrue(Condition := fbDiB.xValue, Message := 'B: open NC contact is TRUE at once, trip not missed');
AssertTrue(Condition := (fbDiB.stSts.stCommon.wStatus AND GVL_Const.DI_STS_TIMING_ON) = 0,
           Message := 'B: no on-delay timing');

coUnit.TEST_FINISHED();
