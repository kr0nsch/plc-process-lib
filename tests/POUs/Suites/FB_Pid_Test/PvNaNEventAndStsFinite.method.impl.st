coUnit.TEST('Pid_PvNaN_EventAndStsFinite');

GVL_Lib.itfAlarmSink := fbSink;
stRetain.eRemoteMode := E_DeviceMode.Auto;
stCmd.rSp_eu := 50.0;
stCmd.rManualOut_pct := 40.0;
fbPid(rPv_eu := 50.0, xPvValid := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
uBits.dwValue := 16#7FC00000;
fbTime.Advance(tStep := T#100MS);
fbPid(rPv_eu := uBits.rValue, xPvValid := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain,
      stCfg := stCfg);
stEv := fbSink.Last;
GVL_Lib.itfAlarmSink := 0;
AssertTrue(Condition := stEv.eReason = E_AlarmEventReason.Activated, Message := 'PvInvalid event');
// AssertEquals_REAL пропускает NaN (ABS(NaN) > Delta = FALSE): конечность проверяется отдельно
AssertTrue(Condition := F_IsFinite(rIn := stEv.rValue), Message := 'event value finite');
AssertTrue(Condition := F_IsFinite(rIn := fbPid.stSts.rPv_eu) AND F_IsFinite(rIn := fbPid.rOut_pct),
           Message := 'Sts PV and output finite');
AssertEquals_REAL(Expected := 0.0, Actual := fbPid.stSts.rPv_eu, Delta := 0.0, Message := 'unknown PV shown as 0');
AssertEquals_REAL(Expected := 40.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'output held');

coUnit.TEST_FINISHED();
