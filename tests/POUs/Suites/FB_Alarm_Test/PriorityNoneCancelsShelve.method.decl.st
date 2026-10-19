// Выключение тревоги (приоритет None) снимает действующий shelve: Normal с событием Disabled (ALM-1),
// xShelved = FALSE, остаток 0. После включения при активном условии — Activated (ActiveUnack), а не Shelved:
// shelve выключенной тревоги не «доживает» до её включения. Контракт 10.2, F-21 (б)
METHOD PRIVATE PriorityNoneCancelsShelve
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // Medium, затем None, затем снова Medium
    fbSink : FB_TestSink;    // приёмник событий
    stEv   : ST_AlarmEvent;  // последнее событие
    udiSeq : UDINT;          // udiSeq до выключения
END_VAR
