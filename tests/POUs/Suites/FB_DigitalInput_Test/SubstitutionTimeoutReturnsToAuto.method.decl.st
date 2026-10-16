// tSubstMax 30 с: подмена TRUE; остаток 30 при входе, 1 в 29 с; ровно через 30 с — Auto, результат SubstExpired,
// значение измеренное (FALSE).
METHOD PRIVATE SubstitutionTimeoutReturnsToAuto
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDi   : FB_DigitalInput;      // ФБ под тестом
    stCmd  : ST_DigitalInputCmd;   // команды
    stCfg  : ST_DigitalInputCfg;   // конфигурация
    iStep  : INT;                  // шаг цикла
END_VAR
