// Выключенная уставка (xEnable = FALSE) не взводит флаг: 10 с значение далеко за уставкой.
METHOD PRIVATE LimitMonitorDisabledNeverSets
VAR
    fbTime   : FB_FakeTime;       // подменное время
    fbLim    : FB_LimitMonitor;   // ФБ под тестом
    stLimCfg : ST_AiLimitCfg;     // параметры уставки
    iStep : INT;             // шаг цикла
    xEverSet : BOOL;            // флаг взводился хотя бы раз
END_VAR
