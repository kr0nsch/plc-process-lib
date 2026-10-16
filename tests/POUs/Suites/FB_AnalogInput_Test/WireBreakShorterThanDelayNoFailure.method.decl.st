// Обрыв на 1,5 с при tFailDelay = 2 с: отказа и тревоги нет ни в одном вызове, значение держится, после возврата
// сигнала — сразу новое измеренное значение; ещё 3 с — без отказа.
METHOD PRIVATE WireBreakShorterThanDelayNoFailure
VAR
    fbTime     : FB_FakeTime;         // подменное время
    fbAi       : FB_AnalogInput;      // ФБ под тестом
    stCmd      : ST_AnalogInputCmd;   // команды
    stCfg      : ST_AnalogInputCfg;   // конфигурация
    itfAlm     : I_Alarm;             // слот тревоги через интерфейс
    iStep      : INT;                 // шаг цикла
    xEverFault : BOOL;                // отказ был хотя бы в одном вызове
END_VAR
