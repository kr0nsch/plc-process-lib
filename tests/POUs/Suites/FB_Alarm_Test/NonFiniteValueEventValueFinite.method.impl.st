coUnit.TEST('Alarm_NonFiniteValue_EventValueFinite');

GVL_Lib.itfAlarmSink := fbSink;
uBits.dwValue := 16#7FC00000;
fbAlm(xIn := TRUE, rValue := uBits.rValue, stCfg := stCfg, itfTime := fbTime);       // Activated при NaN
stEv1 := fbSink.Last;
fbAlm(xIn := FALSE, rValue := 42.5, stCfg := stCfg, itfTime := fbTime);              // Cleared при 42,5
stEv2 := fbSink.Last;
GVL_Lib.itfAlarmSink := 0;
// AssertEquals_REAL пропускает NaN (ABS(NaN) > Delta = FALSE): конечность проверяется отдельно
AssertTrue(Condition := F_IsFinite(rIn := stEv1.rValue), Message := 'NaN value: event value finite');
AssertEquals_REAL(Expected := 0.0, Actual := stEv1.rValue, Delta := 0.0, Message := 'NaN replaced by 0.0');
AssertTrue(Condition := stEv2.eReason = E_AlarmEventReason.Cleared, Message := 'precondition: Cleared event');
AssertEquals_REAL(Expected := 42.5, Actual := stEv2.rValue, Delta := 0.0, Message := 'finite value passed as is');

coUnit.TEST_FINISHED();
