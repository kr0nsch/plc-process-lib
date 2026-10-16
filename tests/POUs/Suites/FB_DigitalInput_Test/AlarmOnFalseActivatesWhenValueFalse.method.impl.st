coUnit.TEST('DigitalInput_AlarmOnFalse_ActivatesWhenValueFalse');

stCfg.xAlarmOnTrue := FALSE;
SetAlarmPriority(stCfgDi := stCfg, uiSlot := E_DiAlarm.State, ePriority := E_AlarmPriority.High);
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
itfAlm := fbDi.GetAlarm(uiIndex := E_DiAlarm.State);
AssertTrue(Condition := itfAlm.State = E_AlarmState.Normal, Message := 'no alarm while TRUE');
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_ALARM_COND) = 0, Message := 'no condition');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'alarm when value FALSE');
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_ALARM_COND) <> 0, Message := 'condition bit');
AssertTrue(Condition := fbDi.stSts.stCommon.ePrioUnack = E_AlarmPriority.High, Message := 'priority High');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := itfAlm.State = E_AlarmState.RtnUnack, Message := 'returned unacknowledged');

coUnit.TEST_FINISHED();
