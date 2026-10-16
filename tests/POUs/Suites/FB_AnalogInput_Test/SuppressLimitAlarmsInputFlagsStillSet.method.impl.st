coUnit.TEST('AnalogInput_SuppressLimitAlarmsInput_FlagsStillSet');

stCfg.eInput := E_AiInputType.Eng;
stCfg.tFailDelay := T#0S;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.H, xEnable := TRUE, rSp_eu := 80.0, rHyst_eu := 2.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 85.0, xSuppressLimitAlarms := TRUE, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbAi.xH, Message := 'flag set');
itfAlm := fbAi.GetAlarm(uiIndex := E_AiAlarm.H);
AssertTrue(Condition := itfAlm.State = E_AlarmState.SuppressedByDesign, Message := 'alarm suppressed by design');
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wAlmUnack, Message := 'nothing unacknowledged');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 85.0, xSuppressLimitAlarms := FALSE, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'alarm annunciated after release');

coUnit.TEST_FINISHED();
