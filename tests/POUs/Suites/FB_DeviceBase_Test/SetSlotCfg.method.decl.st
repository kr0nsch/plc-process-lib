// Помощник: приоритет и срок shelve слота тревоги в Cfg тестового устройства (копия элемента:
// iec_checker 0.4 не разбирает stCfg.astAlarm[i].ePriority)
METHOD PRIVATE SetSlotCfg
VAR_IN_OUT
    stCfgDev : ST_TestDeviceCfg;    // конфигурация устройства
END_VAR
VAR_INPUT
    uiSlot     : UINT;              // номер слота
    ePriority  : E_AlarmPriority;   // приоритет
    tShelveMax : TIME;              // максимальный срок shelve
END_VAR
VAR
    stSlot : ST_AlarmCfg;           // копия слота
END_VAR
