coUnit.TEST('AnalogInput_LimitHH_OnDelay_ShortExcursionIgnored');

stCfg.eInput := E_AiInputType.Eng;
stCfg.tFailDelay := T#0S;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.HH, xEnable := TRUE, rSp_eu := 90.0, rHyst_eu := 1.0, tOnDly := T#3S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 95.0, stCmd := stCmd, stCfg := stCfg);   // t0: выброс
FOR iStep := 1 TO 29 DO                                           // t0 + 2,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 95.0, stCmd := stCmd, stCfg := stCfg);
    xEverHH := xEverHH OR fbAi.xHH;
END_FOR
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 85.0, stCmd := stCmd, stCfg := stCfg);   // t0 + 3,0 с: выброс кончился
xEverHH := xEverHH OR fbAi.xHH;
AssertFalse(Condition := xEverHH, Message := 'excursion shorter than on-delay ignored');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 95.0, stCmd := stCmd, stCfg := stCfg);   // t1
FOR iStep := 1 TO 29 DO   // t1 + 2,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 95.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertFalse(Condition := fbAi.xHH, Message := 'no HH at t1 + 2.9 s');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 95.0, stCmd := stCmd, stCfg := stCfg);   // t1 + 3,0 с
AssertTrue(Condition := fbAi.xHH, Message := 'HH exactly at t1 + 3.0 s');

coUnit.TEST_FINISHED();
