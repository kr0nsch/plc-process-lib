// Подмена, снятая по tSubstMax, и новый запрос подмены в следующем же вызове: срок отсчитывается заново, подмена не
// снимается сразу же. Остаток uiSubstRemain_s — целые секунды с округлением вверх (29,4 с -> 30, 0,3 с -> 1).
METHOD PRIVATE SubstitutionRenewedAfterTimeoutCountsFullPeriod
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDi   : FB_DigitalInput;      // ФБ под тестом
    stCmd  : ST_DigitalInputCmd;   // команды
    stCfg  : ST_DigitalInputCfg;   // конфигурация
END_VAR
