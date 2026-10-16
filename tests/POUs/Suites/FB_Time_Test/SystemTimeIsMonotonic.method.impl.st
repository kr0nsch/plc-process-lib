coUnit.TEST('Time_SystemTime_IsMonotonic');

itfTime := fbSys;
ltFirst := itfTime.Now();
ltPrev := ltFirst;
FOR iStep := 1 TO 20000 DO
    ltNow := itfTime.Now();
    xMonotonic := xMonotonic AND (ltNow >= ltPrev);
    ltPrev := ltNow;
END_FOR
AssertTrue(Condition := xMonotonic, Message := 'LTIME() must not decrease over 20000 calls');
AssertTrue(Condition := ltPrev > ltFirst, Message := 'system time must advance from call to call');
AssertTrue(Condition := ltFirst > LTIME#0S, Message := 'system time must be above zero');

coUnit.TEST_FINISHED();
