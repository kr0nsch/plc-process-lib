// HH 90 с задержкой срабатывания 3 с: выброс 2,9 с флаг не взводит; устойчивое превышение — флаг ровно через 3,0 с.
METHOD PRIVATE LimitHHOnDelayShortExcursionIgnored
VAR
    fbTime  : FB_FakeTime;         // подменное время
    fbAi    : FB_AnalogInput;      // ФБ под тестом
    stCmd   : ST_AnalogInputCmd;   // команды
    stCfg   : ST_AnalogInputCfg;   // конфигурация
    iStep   : INT;                 // шаг цикла
    xEverHH : BOOL;                // HH взводился хотя бы раз
END_VAR
