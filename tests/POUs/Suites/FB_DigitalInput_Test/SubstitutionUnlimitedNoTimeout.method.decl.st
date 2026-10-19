// tSubstMax = T#0S — подмена без ограничения срока: 24 ч в Manual — режим Manual, SubstExpired нет, значение
// подмены TRUE, остаток 0.
METHOD PRIVATE SubstitutionUnlimitedNoTimeout
VAR
    fbTime    : FB_FakeTime;          // подменное время
    fbDi      : FB_DigitalInput;      // ФБ под тестом
    stCmd     : ST_DigitalInputCmd;   // команды
    stCfg     : ST_DigitalInputCfg;   // конфигурация
    iStep     : INT;                  // шаг цикла
    xEverAuto : BOOL;                 // режим хоть раз вернулся в Auto
END_VAR
