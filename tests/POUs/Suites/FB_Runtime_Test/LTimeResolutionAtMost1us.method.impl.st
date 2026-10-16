coUnit.TEST('Runtime_LTime_ResolutionAtMost1us');

itfTime := fbSys;
ltPrev := itfTime.Now();
FOR iStep := 1 TO 20000 DO
    ltNow := itfTime.Now();
    xMonotonic := xMonotonic AND (ltNow >= ltPrev);
    IF ltNow > ltPrev THEN
        uiChanges := uiChanges + 1;
        IF ltNow - ltPrev < ltMinStep THEN
            ltMinStep := ltNow - ltPrev;
        END_IF
    END_IF
    ltPrev := ltNow;
END_FOR
AssertTrue(Condition := xMonotonic, Message := 'LTIME() does not decrease');
AssertTrue(Condition := uiChanges > 0, Message := 'LTIME() changes within 20000 reads');
AssertTrue(Condition := ltMinStep <= LTIME#1US, Message := 'smallest non-zero step at most 1 us');

coUnit.TEST_FINISHED();
