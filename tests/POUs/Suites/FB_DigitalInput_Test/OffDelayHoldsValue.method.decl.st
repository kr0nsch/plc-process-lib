// Задержка отключения 1 с: сигнал пропал — значение держится 0,9 с (бит DI_STS_TIMING_OFF), снимается ровно через 1,0
// с.
METHOD PRIVATE OffDelayHoldsValue
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDi   : FB_DigitalInput;      // ФБ под тестом
    stCmd  : ST_DigitalInputCmd;   // команды
    stCfg  : ST_DigitalInputCfg;   // конфигурация
    iStep  : INT;                  // шаг цикла
END_VAR
