// tSubstMax = T#0S — подмена без ограничения срока (Cfg, контракт 11.1): 24 ч в Manual крупными шагами — режим
// остаётся Manual, результата SubstExpired нет, значение подмены, остаток uiSubstRemain_s = 0.
METHOD PRIVATE SubstitutionUnlimitedNoTimeout
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    iStep  : INT;                 // шаг цикла

    xEverAuto : BOOL;             // режим хоть раз вернулся в Auto
END_VAR
