coUnit.TEST('AnalogInput_OosExitWithBrokenSignal_InvalidAtOnce');

stCfg.rRangeHi_eu := 5.0;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.H, xEnable := TRUE, rSp_eu := 4.0, rHyst_eu := 0.1, tOnDly := T#0S,
         tOffDly := T#0S);
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.LL, xEnable := TRUE, rSp_eu := 0.5, rHyst_eu := 0.1, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 17.6, stCmd := stCmd, stCfg := stCfg);   // t0: 4,25 м, H
AssertTrue(Condition := fbAi.xH, Message := 'H before OOS');
stCmd.stCommon.xSetOos := TRUE;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 17.6, stCmd := stCmd, stCfg := stCfg);   // вывод из работы
FOR iStep := 1 TO 10 DO   // в ремонте: линия оборвана 10 с
    fbTime.Advance(tStep := T#1000MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.Status = E_Ne107Status.CheckFunction, Message := 'no failure in OOS');
stCmd.stCommon.xSetAuto := TRUE;
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);    // te: в работу, линия ещё оборвана
AssertTrue(Condition := fbAi.Mode = E_DeviceMode.Auto, Message := 'back in service');
AssertFalse(Condition := fbAi.xValid, Message := 'stale value from before OOS is not valid');
AssertFalse(Condition := fbAi.xH, Message := 'no H from the stale value');
AssertFalse(Condition := fbAi.xLL, Message := 'no false LL');
AssertEquals_REAL(Expected := 4.25, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'HoldLast keeps held value');
AssertTrue(Condition := (fbAi.stSts.stCommon.wStatus AND GVL_Const.AI_STS_FAIL_PENDING) = 0,
           Message := 'no pending bit: value is not held as valid');
AssertFalse(Condition := fbAi.Fault, Message := 'failure not yet confirmed');
FOR iStep := 1 TO 20 DO   // te + 2,0 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.Fault, Message := 'failure after tFailDelay');
FOR iStep := 1 TO 21 DO   // сигнал вернулся, + 2,1 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertFalse(Condition := fbAi.Fault, Message := 'failure cleared');
AssertTrue(Condition := fbAi.xValid, Message := 'valid with the new measurement');
AssertEquals_REAL(Expected := 3.75, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'measured value');

coUnit.TEST_FINISHED();
