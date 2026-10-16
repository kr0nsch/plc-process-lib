// Остаток shelve убывает со временем: shelve 1 ч, через 15 мин — 45 мин, через 59 мин 59 с — 1 с.
METHOD PRIVATE ShelveRemainCountsDown
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
END_VAR
