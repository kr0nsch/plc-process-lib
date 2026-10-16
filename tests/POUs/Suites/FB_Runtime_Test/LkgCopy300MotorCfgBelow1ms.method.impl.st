coUnit.TEST('Runtime_LkgCopy300MotorCfg_Below1ms');

ltStart := fbSys.Now();
FOR iStep := 1 TO 300 DO
    stSrc.tMinRun := INT_TO_TIME(iStep);
    stDst := stSrc;
END_FOR
ltEnd := fbSys.Now();
AssertEquals_TIME(Expected := T#300MS, Actual := stDst.tMinRun, Message := 'last copy done');
AssertTrue(Condition := ltEnd >= ltStart, Message := 'time does not decrease');
AssertTrue(Condition := ltEnd - ltStart < LTIME#1MS, Message := '300 copies of ST_MotorCfg below 1 ms');

coUnit.TEST_FINISHED();
