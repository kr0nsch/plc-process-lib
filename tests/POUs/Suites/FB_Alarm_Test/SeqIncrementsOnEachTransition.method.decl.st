// udiSeq (и свойство Seq) растёт на 1 на каждом переходе: Activated, Acked, Shelved, Unshelved,
// Cleared, Acked — 6; вызовы без перехода счётчик не меняют.
METHOD PRIVATE SeqIncrementsOnEachTransition
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    itfAlm : I_Alarm;        // тот же ФБ через интерфейс
END_VAR
