// ForceTrue (защитный сигнал: отказ канала = сработал): отказ — значение TRUE сразу, xValid = FALSE, Failure, биты
// DI_FLT_CHANNEL и DI_STS_CHANNEL_FAULT, тревога Failure ActiveUnack, тревога State подавлена (SuppressedByDesign, без
// дублирования). Отказ снят — снова измерение.
METHOD PRIVATE ChannelFaultForceTrue
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDi   : FB_DigitalInput;      // ФБ под тестом
    stCmd  : ST_DigitalInputCmd;   // команды
    stCfg  : ST_DigitalInputCfg;   // конфигурация
    itfAlm : I_Alarm;              // слот тревоги через интерфейс
END_VAR
