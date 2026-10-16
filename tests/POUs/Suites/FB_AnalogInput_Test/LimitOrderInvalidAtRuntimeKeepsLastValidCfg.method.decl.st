// В работе HH испорчена (70 < H 80): бит AI_CFG_LIMIT_ORDER, CheckFunction, но логика работает по последней корректной
// Cfg (HH 90): 85 — только H, 95 — HH; значение пригодно. Исправление Cfg снимает CheckFunction.
METHOD PRIVATE LimitOrderInvalidAtRuntimeKeepsLastValidCfg
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
