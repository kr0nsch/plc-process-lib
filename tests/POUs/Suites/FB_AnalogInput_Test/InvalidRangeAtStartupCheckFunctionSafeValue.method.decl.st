// Шкала 10..10 с первого вызова: бит AI_CFG_RANGE, CheckFunction, безопасное значение 0.0, xValid = FALSE, флаги
// уставок FALSE, Available = FALSE; режим — Auto, тип — AnalogInput.
METHOD PRIVATE InvalidRangeAtStartupCheckFunctionSafeValue
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
