coUnit.TEST('DigitalInput_ChannelFault_ForceTrue');

stCfg.eFailValue := E_DiFailValue.ForceTrue;
SetAlarmPriority(stCfgDi := stCfg, uiSlot := E_DiAlarm.State, ePriority := E_AlarmPriority.Medium);
fbDi(itfTime := fbTime, xIn := FALSE, stCmd := stCmd, stCfg := stCfg);
AssertFalse(Condition := fbDi.xValue, Message := 'value off');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, xChannelFault := TRUE, stCmd := stCmd, stCfg := stCfg);
AssertTrue(Condition := fbDi.xValue, Message := 'forced TRUE on channel fault');
AssertFalse(Condition := fbDi.xValid, Message := 'invalid on channel fault');
AssertTrue(Condition := fbDi.Status = E_Ne107Status.Failure, Message := 'failure');
AssertEquals_WORD(Expected := GVL_Const.DI_FLT_CHANNEL, Actual := fbDi.stSts.stCommon.wFault, Message := 'fault bit');
AssertTrue(Condition := (fbDi.stSts.stCommon.wStatus AND GVL_Const.DI_STS_CHANNEL_FAULT) <> 0, Message := 'status bit');
itfAlm := fbDi.GetAlarm(uiIndex := E_DiAlarm.Failure);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'failure alarm');
itfAlm := fbDi.GetAlarm(uiIndex := E_DiAlarm.State);
AssertTrue(Condition := itfAlm.State = E_AlarmState.SuppressedByDesign, Message := 'state alarm suppressed');
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := FALSE, xChannelFault := FALSE, stCmd := stCmd, stCfg := stCfg);
AssertFalse(Condition := fbDi.xValue, Message := 'measured again');
AssertTrue(Condition := fbDi.xValid, Message := 'valid again');
AssertTrue(Condition := fbDi.Status = E_Ne107Status.Good, Message := 'good again');

coUnit.TEST_FINISHED();
