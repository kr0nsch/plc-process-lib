// ForceFalse: отказ канала при включённом сигнале — значение FALSE сразу, xValid = FALSE.
METHOD PRIVATE ChannelFaultForceFalse
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDi   : FB_DigitalInput;      // ФБ под тестом
    stCmd  : ST_DigitalInputCmd;   // команды
    stCfg  : ST_DigitalInputCfg;   // конфигурация
END_VAR
