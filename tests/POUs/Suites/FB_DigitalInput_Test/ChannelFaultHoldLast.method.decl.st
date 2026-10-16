// HoldLast: при отказе канала держится значение до отказа (TRUE), xValid = FALSE; после отказа задержка отключения 1 с
// отсчитывается от возврата канала.
METHOD PRIVATE ChannelFaultHoldLast
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDi   : FB_DigitalInput;      // ФБ под тестом
    stCmd  : ST_DigitalInputCmd;   // команды
    stCfg  : ST_DigitalInputCfg;   // конфигурация
    iStep  : INT;                  // шаг цикла
END_VAR
