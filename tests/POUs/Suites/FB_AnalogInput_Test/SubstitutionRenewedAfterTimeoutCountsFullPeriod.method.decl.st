// Подмена, снятая по tSubstMax, и новый запрос подмены в следующем же вызове: срок отсчитывается заново,
// подмена не снимается сразу же. Остаток uiSubstRemain_s — целые секунды с округлением вверх
// (59,4 с -> 60, 1,3 с -> 2, 0,1 с -> 1): пока подмена идёт, остаток не 0.
METHOD PRIVATE SubstitutionRenewedAfterTimeoutCountsFullPeriod
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
