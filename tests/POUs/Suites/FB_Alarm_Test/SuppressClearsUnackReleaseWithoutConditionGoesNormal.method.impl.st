coUnit.TEST('Alarm_SuppressClearsUnack_ReleaseWithoutCondition_GoesNormal');

fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);                                // ActiveUnack
fbAlm(xIn := TRUE, xSuppress := TRUE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.SuppressedByDesign, Message := 'ActiveUnack -> SuppressedByDesign');
AssertFalse(Condition := fbAlm.xUnacked, Message := 'unacknowledged flag cleared on entry');
fbAlm(xIn := FALSE, xSuppress := TRUE, stCfg := stCfg, itfTime := fbTime);
fbAlm(xIn := FALSE, xSuppress := FALSE, stCfg := stCfg, itfTime := fbTime);
AssertTrue(Condition := fbAlm.eState = E_AlarmState.Normal, Message := 'release without condition -> Normal');
AssertEquals_UDINT(Expected := 3, Actual := fbAlm.udiSeq, Message := 'three transitions');

coUnit.TEST_FINISHED();
