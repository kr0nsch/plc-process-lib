// Тревога ActiveUnack, приоритет переключили на None (ALM-1): переход в Normal с событием Disabled (старое состояние
// ActiveUnack, новое Normal, udiSeq + 1) — журнал и сводка по событиям закрывают тревогу. Дальше выключенная
// тревога событий не даёт.
METHOD PRIVATE PriorityNoneWhileActiveEmitsClosingEvent
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // Medium, затем None
    fbSink : FB_TestSink;    // приёмник событий
    stEv   : ST_AlarmEvent;  // последнее событие
    udiSeq : UDINT;          // udiSeq до выключения
    uiCnt  : UINT;           // событий после выключения
END_VAR
