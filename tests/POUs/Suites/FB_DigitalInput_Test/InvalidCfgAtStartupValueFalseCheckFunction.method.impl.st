coUnit.TEST('DigitalInput_InvalidCfgAtStartup_ValueFalseCheckFunction');

uEnum.iValue := 5;
stCfg.eFailValue := uEnum.eDiFailValue;
uPrio.iValue := 9;
SetAlarmPriority(stCfgDi := stCfg, uiSlot := E_DiAlarm.State, ePriority := uPrio.ePriority);
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.DI_CFG_FAIL_VALUE OR GVL_Const.DI_CFG_ALARM,
                  Actual := fbDi.stSts.stCommon.wCfgErr, Message := 'fail value and alarm bits');
AssertFalse(Condition := fbDi.xValue, Message := 'safe value FALSE');
AssertFalse(Condition := fbDi.xValid, Message := 'invalid');
AssertFalse(Condition := fbDi.Available, Message := 'not available');
AssertTrue(Condition := fbDi.Status = E_Ne107Status.CheckFunction, Message := 'CheckFunction');
stCfg.eFailValue := E_DiFailValue.HoldLast;
SetAlarmPriority(stCfgDi := stCfg, uiSlot := E_DiAlarm.State, ePriority := E_AlarmPriority.None);
fbTime.Advance(tStep := T#100MS);
fbDi(itfTime := fbTime, xIn := TRUE, stCmd := stCmd, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbDi.stSts.stCommon.wCfgErr, Message := 'Cfg accepted');
AssertTrue(Condition := fbDi.xValue, Message := 'measured value');
AssertTrue(Condition := fbDi.xValid, Message := 'valid');

coUnit.TEST_FINISHED();
