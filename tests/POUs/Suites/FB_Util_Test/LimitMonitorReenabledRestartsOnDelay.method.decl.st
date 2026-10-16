// Выключение уставки во время задержки срабатывания (2 с) сбрасывает отсчёт: после повторного
// включения в t0 + 1,6 с флаг — ровно через 2 с от включения, а не в t0 + 2,0 с.
METHOD PRIVATE LimitMonitorReenabledRestartsOnDelay
VAR
    fbTime   : FB_FakeTime;       // подменное время
    fbLim    : FB_LimitMonitor;   // ФБ под тестом
    stLimCfg : ST_AiLimitCfg;     // параметры уставки
    iStep : INT;             // шаг цикла
END_VAR
