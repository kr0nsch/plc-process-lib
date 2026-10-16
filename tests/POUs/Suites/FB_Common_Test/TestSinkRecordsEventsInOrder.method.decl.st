// FB_TestSink через PL.GVL_Lib.itfAlarmSink (как его вызывает FB_Alarm): события по порядку,
// Last и GetEvent, кольцо на 32 события (33 события — остаются 32 последних), Clear. Приёмник
// возвращается в 0 до конца теста.
METHOD PRIVATE TestSinkRecordsEventsInOrder
VAR
    fbSink    : FB_TestSink;       // приёмник под тестом
    stEv1     : ST_AlarmEvent;     // первое событие
    stEv2     : ST_AlarmEvent;     // второе событие
    stGot     : ST_AlarmEvent;     // прочитанное событие
    xAccepted : BOOL;              // ответ приёмника
    uiEvent   : UINT;              // номер события в цикле
END_VAR
