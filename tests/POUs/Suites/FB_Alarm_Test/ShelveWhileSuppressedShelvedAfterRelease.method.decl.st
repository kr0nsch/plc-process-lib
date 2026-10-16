// Shelve во время подавления принимается (не OutOfService): состояние остаётся SuppressedByDesign,
// xShelved = TRUE, событий нет; снятие подавления — Shelved (причина Unsuppressed).
METHOD PRIVATE ShelveWhileSuppressedShelvedAfterRelease
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    fbSink : FB_TestSink;    // приёмник событий
    stEv   : ST_AlarmEvent;  // последнее событие
    xRet   : BOOL;           // ответ Shelve
END_VAR
