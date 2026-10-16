coUnit.TEST('AnalogInput_ShortGlitch_FilterKeptNoFalseLimit');

stCfg.tFilter := T#10S;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.HH, xEnable := TRUE, rSp_eu := 70.0, rHyst_eu := 1.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t0: фильтр начат с 50
FOR iStep := 1 TO 10 DO   // ступень 75, t0 + 1,0 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertEquals_REAL(Expected := 52.37906, Actual := fbAi.rValue_eu, Delta := 1.0E-3, Message := 'filtered before glitch');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 16.0, xChannelFault := TRUE, stCmd := stCmd, stCfg := stCfg);   // провал
AssertEquals_REAL(Expected := 52.37906, Actual := fbAi.rValue_eu, Delta := 1.0E-3, Message := 'held during glitch');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.AI_STS_FAIL_PENDING) <> 0,
           Message := 'fail pending');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 16.0, xChannelFault := FALSE, stCmd := stCmd, stCfg := stCfg);   // после провала
xEverHH := fbAi.xHH;
AssertEquals_REAL(Expected := 52.60415, Actual := fbAi.rValue_eu, Delta := 1.0E-3,
                  Message := 'filter continues from its state (75 if restarted)');
AssertTrue(Condition := fbAi.xValid, Message := 'valid');
FOR iStep := 1 TO 5 DO   // ещё 0,5 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);
    xEverHH := xEverHH OR fbAi.xHH;
END_FOR
AssertFalse(Condition := xEverHH, Message := 'no false HH after a short glitch');
AssertFalse(Condition := fbAi.Fault, Message := 'no failure');

coUnit.TEST_FINISHED();
