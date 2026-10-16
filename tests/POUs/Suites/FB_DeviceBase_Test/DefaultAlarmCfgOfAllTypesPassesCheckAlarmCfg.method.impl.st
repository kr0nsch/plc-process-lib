coUnit.TEST('Device_DefaultAlarmCfgOfAllTypes_PassesCheckAlarmCfg');

AssertTrue(Condition := fbDev.ProbeAlarmCfg(astCfgIn := stAi.astAlarm), Message := 'AI defaults');
AssertTrue(Condition := fbDev.ProbeAlarmCfg(astCfgIn := stDi.astAlarm), Message := 'DI defaults');
AssertTrue(Condition := fbDev.ProbeAlarmCfg(astCfgIn := stMot.astAlarm), Message := 'motor defaults');
AssertTrue(Condition := fbDev.ProbeAlarmCfg(astCfgIn := stVlv.astAlarm), Message := 'valve defaults');
AssertTrue(Condition := fbDev.ProbeAlarmCfg(astCfgIn := stCv.astAlarm), Message := 'control valve defaults');
AssertTrue(Condition := fbDev.ProbeAlarmCfg(astCfgIn := stPid.astAlarm), Message := 'PID defaults');
AssertTrue(Condition := fbDev.ProbeAlarmCfg(astCfgIn := stTest.astAlarm), Message := 'test device defaults');
uBad.iValue := 5;
stSlot := stMot.astAlarm[7];
stSlot.ePriority := uBad.ePriority;
stMot.astAlarm[7] := stSlot;
AssertFalse(Condition := fbDev.ProbeAlarmCfg(astCfgIn := stMot.astAlarm), Message := 'priority 5 rejected');
uBad.iValue := -1;
stSlot.ePriority := uBad.ePriority;
stMot.astAlarm[7] := stSlot;
AssertFalse(Condition := fbDev.ProbeAlarmCfg(astCfgIn := stMot.astAlarm), Message := 'priority -1 rejected');
uBad.iValue := 4;
stSlot.ePriority := uBad.ePriority;
stMot.astAlarm[7] := stSlot;
AssertTrue(Condition := fbDev.ProbeAlarmCfg(astCfgIn := stMot.astAlarm), Message := 'priority 4 (Critical) valid');

coUnit.TEST_FINISHED();
