// Помощник: приоритет слота тревоги в Cfg двигателя (через копию элемента)
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
