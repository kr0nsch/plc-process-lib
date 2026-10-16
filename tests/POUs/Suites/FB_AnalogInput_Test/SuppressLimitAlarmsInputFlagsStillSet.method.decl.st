// xSuppressLimitAlarms: флаг H считается (логика станции его видит), а тревога H — SuppressedByDesign, не
// неквитирована; вход снят — тревога ActiveUnack.
METHOD PRIVATE SuppressLimitAlarmsInputFlagsStillSet
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    itfAlm : I_Alarm;             // слот тревоги через интерфейс
END_VAR
