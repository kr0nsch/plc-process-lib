// Подавление по условию: при xSuppress активная тревога — SuppressedByDesign, не в списке, не
// требует квитирования (Ack — FALSE), xActive показывает условие. Снятие подавления при активном
// условии — ActiveUnack (причина Unsuppressed): оператор видит тревогу заново.
METHOD PRIVATE SuppressByDesignNoAnnunciation
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    fbSink : FB_TestSink;    // приёмник событий
    stEv   : ST_AlarmEvent;  // последнее событие
    xRet   : BOOL;           // ответ Ack
    iStep  : INT;            // шаг цикла
END_VAR
