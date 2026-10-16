// По умолчанию значение экстраполируется (20,4 мА — 102,5 %); с xClamp — ограничено шкалой (100 и 0) с предупреждением
// AI_WRN_CLAMPED. источник: tools/reference/ai_reference.py, сценарии scale «20,4 мА без ограничения», «… с
// ограничением», «3,9 мА с ограничением».
METHOD PRIVATE ClampLimitsToRange
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
