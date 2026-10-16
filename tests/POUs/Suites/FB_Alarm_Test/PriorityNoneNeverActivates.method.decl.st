// Приоритет None выключает тревогу: при активном условии 10 вызовов — Normal, все выходы FALSE,
// udiSeq = 0, событий нет; Shelve и Ack — FALSE.
METHOD PRIVATE PriorityNoneNeverActivates
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // приоритет None
    fbSink : FB_TestSink;    // приёмник событий
    xEver  : BOOL;           // хоть раз взведён какой-либо выход
    xRet   : BOOL;           // ответы методов
    iStep  : INT;            // шаг цикла
END_VAR
