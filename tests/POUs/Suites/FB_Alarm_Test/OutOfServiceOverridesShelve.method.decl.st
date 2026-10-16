// OutOfService старше shelve: отложенная тревога уходит в OutOfService, срок shelve продолжает
// идти (xShelved = TRUE); Shelve в OutOfService не принимается. Выход из OutOfService до конца
// срока — снова Shelved с остатком 40 мин; срок, истёкший в OutOfService, — при выходе базовое
// состояние (условие активно — ActiveUnack).
METHOD PRIVATE OutOfServiceOverridesShelve
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    fbSink : FB_TestSink;    // приёмник событий
    stEv   : ST_AlarmEvent;  // последнее событие
    xRet   : BOOL;           // ответ Shelve
END_VAR
