// Квитированная активная тревога, условие ушло: ActiveAck → Normal (причина Cleared).
METHOD PRIVATE ActiveAckReturnGoesNormal
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    fbSink : FB_TestSink;    // приёмник событий
    stEv   : ST_AlarmEvent;  // последнее событие
END_VAR
