coUnit.TEST('AnalogInput_LimitOffDelay_HoldsFlag');

stCfg.eInput := E_AiInputType.Eng;
stCfg.tFailDelay := T#0S;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.H, xEnable := TRUE, rSp_eu := 80.0, rHyst_eu := 0.0, tOnDly := T#0S,
         tOffDly := T#2S);
fbAi(itfTime := fbTime, rIn := 85.0, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.xH, Message := 'H set');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 70.0, stCmd := stCmd, stCfg := stCfg);   // t1: ниже уставки
FOR iStep := 1 TO 19 DO   // t1 + 1,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 70.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.xH, Message := 'H held by off-delay');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 70.0, stCmd := stCmd, stCfg := stCfg);   // t1 + 2,0 с
AssertFalse(Condition := fbAi.xH, Message := 'H cleared after off-delay');

coUnit.TEST_FINISHED();
