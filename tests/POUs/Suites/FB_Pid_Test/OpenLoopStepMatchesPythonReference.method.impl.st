coUnit.TEST('FopdtModel_OpenLoopStep_MatchesPythonReference');
// источник: tools/reference/pid.py, сценарий fopdt_open
fbPlant.rU_pct := 10.0;
FOR iStep := 1 TO 240 DO
    fbPlant.Step();
    IF iStep = 40 THEN
        rY40 := fbPlant.rY;
    ELSIF iStep = 41 THEN
        rY41 := fbPlant.rY;
    END_IF
END_FOR
// ref: fopdt_open.y_40
AssertEquals_REAL(Expected := 0.0, Actual := rY40, Delta := 1.0E-6, Message := 'dead time 4 s: no response yet');
// ref: fopdt_open.y_41
AssertEquals_REAL(Expected := 0.1, Actual := rY41, Delta := 1.0E-6, Message := 'first response dt / T * K * u');
// ref: fopdt_open.y_240
AssertEquals_REAL(Expected := 12.660844, Actual := fbPlant.rY, Delta := 1.0E-4, Message := 'response after 24 s');
coUnit.TEST_FINISHED();
