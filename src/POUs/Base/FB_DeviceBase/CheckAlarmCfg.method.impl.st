FOR uiLoop := 1 TO GVL_Const.DEV_ALARMS_MAX DO
    stSlot := astCfg[uiLoop - 1];
    xOk := xOk AND (stSlot.ePriority = E_AlarmPriority.None OR stSlot.ePriority = E_AlarmPriority.Low
                    OR stSlot.ePriority = E_AlarmPriority.Medium OR stSlot.ePriority = E_AlarmPriority.High
                    OR stSlot.ePriority = E_AlarmPriority.Critical);
END_FOR
CheckAlarmCfg := xOk;
