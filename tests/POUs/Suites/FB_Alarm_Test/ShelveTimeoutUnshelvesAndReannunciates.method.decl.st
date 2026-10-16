// Shelve квитированной активной тревоги на tShelveMax = 8 ч (T#0S в запросе): Shelved, остаток 8 ч,
// тревога не в списке. По истечении срока при активном условии — снова ActiveUnack (повторное
// оповещение, причина ShelveExpired); в 7 ч 50 мин ещё Shelved. Шаг времени 10 мин.
METHOD PRIVATE ShelveTimeoutUnshelvesAndReannunciates
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // tShelveMax = 8 ч (по умолчанию)
    fbSink : FB_TestSink;    // приёмник событий
    stEv   : ST_AlarmEvent;  // последнее событие
    xRet   : BOOL;           // ответ Shelve
    iStep  : INT;            // шаг цикла
END_VAR
