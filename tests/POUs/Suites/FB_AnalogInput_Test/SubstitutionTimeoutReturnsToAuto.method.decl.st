// tSubstMax 1 мин: подмена 42; остаток uiSubstRemain_s 60 при входе, 1 в 59 с; ровно через 60 с ФБ сам возвращается в
// Auto: результат SubstExpired (+1 к uiCmdSeq), значение измеренное, остаток 0.
METHOD PRIVATE SubstitutionTimeoutReturnsToAuto
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    iStep  : INT;                 // шаг цикла
    uiSeq  : UINT;                // номер команды до снятия подмены
END_VAR
