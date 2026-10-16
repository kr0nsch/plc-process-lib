coUnit.TEST('Alarm_PriorityOutOfEnum_TreatedAsMedium');

uBad.iValue := 9;
stCfg.ePriority := uBad.ePriority;
itfAlm := fbAlm;
GVL_Lib.itfAlarmSink := fbSink;
fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
GVL_Lib.itfAlarmSink := 0;
AssertTrue(Condition := fbAlm.eState = E_AlarmState.ActiveUnack,
           Message := 'garbage priority does not disable the alarm');
AssertTrue(Condition := itfAlm.AlarmPriority = E_AlarmPriority.Medium, Message := 'treated as Medium');
stEv := fbSink.Last;
AssertTrue(Condition := stEv.ePriority = E_AlarmPriority.Medium, Message := 'event priority Medium');

coUnit.TEST_FINISHED();
