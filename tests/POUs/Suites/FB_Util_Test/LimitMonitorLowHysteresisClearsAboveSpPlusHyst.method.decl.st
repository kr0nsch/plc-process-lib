// Нижняя уставка 20, гистерезис 2 — зеркально: флаг при значении <= 20, держится до 22
// включительно, снимается выше 22.
METHOD PRIVATE LimitMonitorLowHysteresisClearsAboveSpPlusHyst
VAR
    fbTime   : FB_FakeTime;       // подменное время
    fbLim    : FB_LimitMonitor;   // ФБ под тестом
    stLimCfg : ST_AiLimitCfg;     // параметры уставки
END_VAR
