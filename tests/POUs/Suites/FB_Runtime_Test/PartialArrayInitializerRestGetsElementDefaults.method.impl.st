coUnit.TEST('Runtime_PartialArrayInitializer_RestGetsElementDefaults');

stSlot := stPart.astAlarm[0];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Low, Message := 'slot 0 from the initializer');
stSlot := stPart.astAlarm[3];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Medium,
           Message := 'slot 3 gets the ST_AlarmCfg default Medium');
stSlot := stPart.astAlarm[1];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Medium,
           Message := 'slot 1 gets the ST_AlarmCfg default Medium');
AssertEquals_TIME(Expected := T#8H, Actual := stSlot.tShelveMax, Message := 'other slot fields: ST_AlarmCfg defaults');
stSlot := stFull.astAlarm[3];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.High,
           Message := 'without an initializer slot 3 keeps the DUT default High');
AssertEquals_REAL(Expected := 5.0, Actual := stPart.rRangeHi_eu, Delta := 0.0, Message := 'initialized field');
AssertEquals_TIME(Expected := T#2S, Actual := stPart.tFailDelay, Message := 'other Cfg fields keep the DUT defaults');

coUnit.TEST_FINISHED();
