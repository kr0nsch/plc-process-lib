coUnit.TEST('Device_AlarmIds_BaseFromCfgPlusSlot');

stCfg.udiAlarmIdBase := 120;
fbDev.axCondIn[5] := TRUE;
GVL_Lib.itfAlarmSink := fbSink;
fbDev(rValueIn := 7.5, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
GVL_Lib.itfAlarmSink := 0;
itfAlm := fbDev.GetAlarm(uiIndex := 5);
AssertEquals_UDINT(Expected := 125, Actual := itfAlm.Id, Message := 'id = base + slot');
stEv := fbSink.Last;
AssertEquals_UDINT(Expected := 125, Actual := stEv.udiId, Message := 'event id');
AssertEquals_REAL(Expected := 7.5, Actual := stEv.rValue, Delta := 0.0, Message := 'event value from arAlmValue');
AssertEquals_UINT(Expected := 1, Actual := fbSink.Count, Message := 'one event');

coUnit.TEST_FINISHED();
