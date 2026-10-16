coUnit.TEST('DigitalInput_AlarmEvents_ValueIsZeroOrOne');

stCfg.udiAlarmIdBase := 70;
SetAlarmPriority(stCfgDi := stCfg, uiSlot := E_DiAlarm.State, ePriority := E_AlarmPriority.Medium);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
GVL_Lib.itfAlarmSink := fbSink;
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);    // State: появление
stEvOn := fbSink.Last;
fbSink.Clear();
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);   // State: снятие
stEvOff := fbSink.Last;
GVL_Lib.itfAlarmSink := 0;
AssertEquals_UDINT(Expected := 70, Actual := stEvOn.udiId, Message := 'State id = base + 0');
AssertTrue(Condition := stEvOn.eReason = E_AlarmEventReason.Activated, Message := 'Activated');
AssertEquals_REAL(Expected := 1.0, Actual := stEvOn.rValue, Delta := 0.0, Message := 'value TRUE as 1.0');
AssertTrue(Condition := stEvOff.eReason = E_AlarmEventReason.Cleared, Message := 'Cleared');
AssertEquals_REAL(Expected := 0.0, Actual := stEvOff.rValue, Delta := 0.0, Message := 'value FALSE as 0.0');

coUnit.TEST_FINISHED();
