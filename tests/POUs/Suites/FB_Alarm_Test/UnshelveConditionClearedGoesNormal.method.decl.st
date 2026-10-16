// Условие ушло, пока тревога отложена: состояние Shelved, xActive = FALSE. Unshelve переводит в
// Normal (причина Unshelved), без повторного оповещения.
METHOD PRIVATE UnshelveConditionClearedGoesNormal
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    fbSink : FB_TestSink;    // приёмник событий
    stEv   : ST_AlarmEvent;  // последнее событие
    xRet   : BOOL;           // ответ Unshelve
END_VAR
