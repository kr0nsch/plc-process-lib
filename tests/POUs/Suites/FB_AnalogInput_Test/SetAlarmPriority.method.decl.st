// Помощник: приоритет слота тревоги uiSlot в Cfg входа (копия элемента, как SetLimit)
METHOD PRIVATE SetAlarmPriority
VAR_IN_OUT
    stCfgAi : ST_AnalogInputCfg;   // конфигурация входа
END_VAR
VAR_INPUT
    uiSlot    : UINT;              // слот: E_AiAlarm
    ePriority : E_AlarmPriority;   // приоритет
END_VAR
VAR
    stSlot : ST_AlarmCfg;          // копия слота
END_VAR
