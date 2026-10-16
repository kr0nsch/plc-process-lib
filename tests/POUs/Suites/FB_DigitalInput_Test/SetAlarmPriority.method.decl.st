// Помощник: приоритет слота тревоги uiSlot в Cfg входа (через копию элемента)
METHOD PRIVATE SetAlarmPriority
VAR_IN_OUT
    stCfgDi : ST_DigitalInputCfg;  // конфигурация входа
END_VAR
VAR_INPUT
    uiSlot    : UINT;              // слот: E_DiAlarm
    ePriority : E_AlarmPriority;   // приоритет
END_VAR
VAR
    stSlot : ST_AlarmCfg;          // копия слота
END_VAR
