// Задержка срабатывания 3 с: выброс 2,9 с за уставку флаг не взводит (сырой флаг — да);
// устойчивое превышение — флаг ровно через 3 с.
METHOD PRIVATE LimitMonitorOnDelayShortExcursionIgnored
VAR
    fbTime   : FB_FakeTime;       // подменное время
    fbLim    : FB_LimitMonitor;   // ФБ под тестом
    stLimCfg : ST_AiLimitCfg;     // параметры уставки
    iStep : INT;             // шаг цикла
    xEverSet : BOOL;            // флаг взводился хотя бы раз
END_VAR
