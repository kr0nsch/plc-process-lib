// HoldLast (по умолчанию): при обрыве значение 3,75 (16 мА на шкале 0..5) держится и до подтверждения, и после него
// (xValid = FALSE); проценты и слежение в stCmd — то же значение.
METHOD PRIVATE WireBreakHoldsLastGoodValue
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    iStep  : INT;                 // шаг цикла
END_VAR
