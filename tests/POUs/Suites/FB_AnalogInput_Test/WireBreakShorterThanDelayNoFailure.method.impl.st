coUnit.TEST('AnalogInput_WireBreakShorterThanDelay_NoFailure');

stCfg.rRangeHi_eu := 5.0;
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t0: 2,5
FOR iStep := 1 TO 15 DO                                           // обрыв t0 + 0,1 … t0 + 1,5 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
    xEverFault := xEverFault OR fbAi.Fault OR NOT fbAi.xValid;
END_FOR
AssertEquals_REAL(Expected := 2.5, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'held during short break');
FOR iStep := 1 TO 30 DO                                           // сигнал вернулся: 16 мА, 3 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);
    xEverFault := xEverFault OR fbAi.Fault OR NOT fbAi.xValid;
END_FOR
AssertFalse(Condition := xEverFault, Message := 'break shorter than tFailDelay gives no failure');
AssertEquals_REAL(Expected := 3.75, Actual := fbAi.rValue_eu, Delta := 1.0E-5, Message := 'measured after return');
itfAlm := fbAi.GetAlarm(uiIndex := E_AiAlarm.Failure);
AssertTrue(Condition := itfAlm.State = E_AlarmState.Normal, Message := 'no failure alarm');

coUnit.TEST_FINISHED();
