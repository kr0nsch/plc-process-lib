// Квитирование и уход условия в одном вызове: два перехода по порядку шагов тела — Acked
// (ActiveUnack → ActiveAck), затем Cleared (ActiveAck → Normal); udiSeq + 2.
METHOD PRIVATE AckAndClearSameCallTwoEventsInOrder
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    fbSink : FB_TestSink;    // приёмник событий
    stEv   : ST_AlarmEvent;  // прочитанное событие
END_VAR
