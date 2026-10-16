// Помощник: приоритет слота тревоги в Cfg двигателя (копия элемента: iec_checker 0.4 не разбирает
// stCfg.astAlarm[i].ePriority)
METHOD PRIVATE SetSlotPriority
VAR_IN_OUT
    stCfgMot : ST_MotorCfg;         // конфигурация двигателя
END_VAR
VAR_INPUT
    uiSlot    : UINT;               // номер слота
    ePrioSlot : E_AlarmPriority;    // приоритет
END_VAR
VAR
    stSlot : ST_AlarmCfg;           // копия слота
END_VAR
