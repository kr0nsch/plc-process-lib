coUnit.TEST('AnalogInput_SignalRecovered_ClearsFailureAfterDelayAndResetsFilter');

stCfg.tFilter := T#10S;
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t0: фильтр начат с 50 %
FOR iStep := 1 TO 30 DO   // обрыв 3 с: отказ подтверждён
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.Fault, Message := 'failure confirmed');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);   // tr: сигнал вернулся, 75 %
FOR iStep := 1 TO 19 DO   // tr + 1,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.Fault, Message := 'failure kept until tFailDelay after recovery');
AssertFalse(Condition := fbAi.xValid, Message := 'still invalid while recovery is confirmed');
AssertEquals_REAL(Expected := 50.0, Actual := fbAi.rValue_eu, Delta := 1.0E-3, Message := 'value held');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 16.0, stCmd := stCmd, stCfg := stCfg);   // tr + 2,0 с
AssertFalse(Condition := fbAi.Fault, Message := 'failure cleared exactly tFailDelay after recovery');
AssertTrue(Condition := fbAi.xValid, Message := 'valid again');
AssertEquals_REAL(Expected := 75.0, Actual := fbAi.rValue_eu, Delta := 1.0E-3,
                  Message := 'filter restarted from current value (54.53 without restart)');

coUnit.TEST_FINISHED();
