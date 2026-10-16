// Верхняя уставка 80, гистерезис 5: флаг при значении >= 80 (включительно), держится до 75
// включительно, снимается ниже 75; в зоне гистерезиса снятый флаг не возвращается.
METHOD PRIVATE LimitMonitorHighHysteresisClearsBelowSpMinusHyst
VAR
    fbTime   : FB_FakeTime;       // подменное время
    fbLim    : FB_LimitMonitor;   // ФБ под тестом
    stLimCfg : ST_AiLimitCfg;     // параметры уставки
END_VAR
