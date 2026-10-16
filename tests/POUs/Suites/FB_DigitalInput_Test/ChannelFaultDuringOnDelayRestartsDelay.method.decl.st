// Отказ канала во время задержки включения: сигнал при отказе недостоверен, поэтому задержка после возврата канала
// отсчитывается заново (DI-2), а не продолжается с момента фронта; биты отсчёта во время отказа не выставляются.
// tOnDelay = 1 с: фронт в t0, отказ t0 + 0,6 … t0 + 0,8 с, возврат tr = t0 + 0,8 с — значение в tr + 1,0 с.
METHOD PRIVATE ChannelFaultDuringOnDelayRestartsDelay
VAR
    fbTime  : FB_FakeTime;          // подменное время
    fbDi    : FB_DigitalInput;      // ФБ под тестом
    stCmd   : ST_DigitalInputCmd;   // команды
    stCfg   : ST_DigitalInputCfg;   // конфигурация
    iStep   : INT;                  // шаг цикла
    xEverOn : BOOL;                 // значение включалось хотя бы раз
END_VAR
