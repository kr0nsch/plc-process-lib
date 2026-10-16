// «Время назад» (SetNow на 1 с раньше): шаг времени 0 — фильтр стоит, значение не прыгает и конечно; следующий шаг
// вперёд продолжает фильтр от того же значения.
METHOD PRIVATE TimeBackwardsFilterHoldsWithoutJump
VAR
    fbTime  : FB_FakeTime;         // подменное время
    fbAi    : FB_AnalogInput;      // ФБ под тестом
    stCmd   : ST_AnalogInputCmd;   // команды
    stCfg   : ST_AnalogInputCfg;   // конфигурация
    iStep   : INT;                 // шаг цикла
    rBefore : REAL;                // значение до скачка времени
END_VAR
