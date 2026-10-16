// xForceOff снимает флаг и сырой флаг в том же вызове, несмотря на задержку снятия 10 с; после
// снятия xForceOff флаг возвращается (значение по-прежнему выше уставки, задержки включения нет).
METHOD PRIVATE LimitMonitorForceOffClearsImmediately
VAR
    fbTime   : FB_FakeTime;       // подменное время
    fbLim    : FB_LimitMonitor;   // ФБ под тестом
    stLimCfg : ST_AiLimitCfg;     // параметры уставки
END_VAR
