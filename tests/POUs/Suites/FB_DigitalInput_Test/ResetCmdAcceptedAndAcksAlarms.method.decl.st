// xReset у DI — команда без фиксируемых отказов: результат Accepted, uiCmdSeq + 1, бит сброшен; тревога Failure после
// отказа канала (RtnUnack) квитирована.
METHOD PRIVATE ResetCmdAcceptedAndAcksAlarms
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDi   : FB_DigitalInput;      // ФБ под тестом
    stCmd  : ST_DigitalInputCmd;   // команды
    stCfg  : ST_DigitalInputCfg;   // конфигурация
    itfAlm : I_Alarm;              // слот тревоги через интерфейс
    uiSeq  : UINT;                 // номер команды до сброса
END_VAR
