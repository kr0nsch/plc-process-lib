coUnit.TEST('AnalogInput_Filter_IndependentOfCycleTime');

stCfg.tFilter := T#10S;
fbAiA(itfTime := fbTimeA, rIn := 4.0, stCmd := stCmdA, stCfg := stCfg);
fbAiB(itfTime := fbTimeB, rIn := 4.0, stCmd := stCmdB, stCfg := stCfg);
fbAiC(itfTime := fbTimeC, rIn := 4.0, stCmd := stCmdC, stCfg := stCfg);
FOR iStep := 1 TO 500 DO
    fbTimeA.Advance(tStep := T#10MS);
    fbAiA(itfTime := fbTimeA, rIn := 20.0, stCmd := stCmdA, stCfg := stCfg);
END_FOR
FOR iStep := 1 TO 20 DO
    fbTimeB.Advance(tStep := T#250MS);
    fbAiB(itfTime := fbTimeB, rIn := 20.0, stCmd := stCmdB, stCfg := stCfg);
END_FOR
FOR iStep := 1 TO 10 DO
    fbTimeC.Advance(tStep := T#50MS);
    fbAiC(itfTime := fbTimeC, rIn := 20.0, stCmd := stCmdC, stCfg := stCfg);
    fbTimeC.Advance(tStep := T#150MS);
    fbAiC(itfTime := fbTimeC, rIn := 20.0, stCmd := stCmdC, stCfg := stCfg);
    fbTimeC.Advance(tStep := T#300MS);
    fbAiC(itfTime := fbTimeC, rIn := 20.0, stCmd := stCmdC, stCfg := stCfg);
END_FOR
AssertEquals_REAL(Expected := 39.34694, Actual := fbAiA.rValue_eu, Delta := 1.0E-3, Message := '10 ms steps');
AssertEquals_REAL(Expected := 39.34694, Actual := fbAiB.rValue_eu, Delta := 1.0E-3, Message := '250 ms steps');
AssertEquals_REAL(Expected := 39.34694, Actual := fbAiC.rValue_eu, Delta := 1.0E-3, Message := 'irregular steps');
AssertEquals_REAL(Expected := fbAiA.rValue_eu, Actual := fbAiB.rValue_eu, Delta := 1.0E-4,
                  Message := 'same result for 10 ms and 250 ms');

coUnit.TEST_FINISHED();
