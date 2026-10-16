coUnit.TEST('AnalogInput_AlarmEvents_FailureValueIsRawInput');

stCfg.udiAlarmIdBase := 120;
stCfg.tFailDelay := T#0S;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.HH, xEnable := TRUE, rSp_eu := 90.0, rHyst_eu := 1.0, tOnDly := T#0S,
         tOffDly := T#0S);
GVL_Lib.itfAlarmSink := fbSink;
fbAi(itfTime := fbTime, rIn := 19.2, stCmd := stCmd, stCfg := stCfg);   // 95 %: HH
stEv := fbSink.Last;
AssertEquals_UDINT(Expected := 120, Actual := stEv.udiId, Message := 'HH id = base + 0');
AssertEquals_REAL(Expected := 95.0, Actual := stEv.rValue, Delta := 1.0E-4, Message := 'HH event value is rValue_eu');
fbSink.Clear();
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 22.5, stCmd := stCmd, stCfg := stCfg);   // FailHigh
stEv := fbSink.GetEvent(uiBack := 0);
GVL_Lib.itfAlarmSink := 0;
AssertTrue(Condition := fbSink.Count >= 1, Message := 'failure event sent');
AssertEquals_UDINT(Expected := 124, Actual := stEv.udiId, Message := 'failure id = base + 4');
AssertEquals_REAL(Expected := 22.5, Actual := stEv.rValue, Delta := 0.0, Message := 'failure event value is rIn');

coUnit.TEST_FINISHED();
