// Каждый переход отправляет событие в GVL_Lib.itfAlarmSink: номер, приоритет, старое и новое
// состояние, причина, отметка времени и значение процесса.
METHOD PRIVATE TransitionSendsEventToSink
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // приоритет High
    fbSink : FB_TestSink;    // приёмник событий
    stEv   : ST_AlarmEvent;  // прочитанное событие
    ltAct  : LTIME;          // время появления
END_VAR
