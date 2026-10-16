// Проверка конфигурации тревог для CheckConfig устройства: TRUE, если приоритеты всех слотов —
// значения перечисления E_AlarmPriority (0…4). Граница массива — числом (iec_checker 0.4)
METHOD PROTECTED CheckAlarmCfg : BOOL
VAR_IN_OUT CONSTANT
    // lint:allow STL007 VAR_IN_OUT CONSTANT массив a<префикс> (имя по контракту), см. docs/STATIC_ANALYSIS.md
    astCfg : ARRAY[0..7] OF ST_AlarmCfg;   // stCfgIn.astAlarm устройства
END_VAR
VAR
    uiLoop : UINT;            // номер слота + 1
    stSlot : ST_AlarmCfg;     // копия слота (iec_checker 0.4 не разбирает astCfg[i].ePriority)
    xOk    : BOOL := TRUE;    // все проверенные слоты корректны
END_VAR
