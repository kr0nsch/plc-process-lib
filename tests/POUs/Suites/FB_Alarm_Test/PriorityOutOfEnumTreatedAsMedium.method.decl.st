// Приоритет вне перечисления (9 — мусор persistent-памяти) не выключает тревогу: она работает как
// Medium, свойство и событие показывают Medium.
METHOD PRIVATE PriorityOutOfEnumTreatedAsMedium
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // приоритет 9
    uBad   : U_TestEnumInt;  // число вне перечисления
    fbSink : FB_TestSink;    // приёмник событий
    stEv   : ST_AlarmEvent;  // последнее событие
    itfAlm : I_Alarm;        // тот же ФБ через интерфейс
END_VAR
