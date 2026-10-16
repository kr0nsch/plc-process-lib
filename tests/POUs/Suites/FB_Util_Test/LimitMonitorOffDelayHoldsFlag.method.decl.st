// Задержка снятия 2 с: сырой флаг снимается сразу, выходной держится до t0 + 1,9 с и снимается
// ровно в t0 + 2,0 с.
METHOD PRIVATE LimitMonitorOffDelayHoldsFlag
VAR
    fbTime   : FB_FakeTime;       // подменное время
    fbLim    : FB_LimitMonitor;   // ФБ под тестом
    stLimCfg : ST_AiLimitCfg;     // параметры уставки
    iStep : INT;             // шаг цикла
END_VAR
