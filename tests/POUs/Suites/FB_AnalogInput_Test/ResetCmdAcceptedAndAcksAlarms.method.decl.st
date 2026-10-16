// Фиксируемых отказов у AI нет, но xReset — команда: результат Accepted, uiCmdSeq + 1, бит сброшен; неквитированная
// тревога Failure (RtnUnack после возврата сигнала) квитируется — Normal.
METHOD PRIVATE ResetCmdAcceptedAndAcksAlarms
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    itfAlm : I_Alarm;             // слот тревоги через интерфейс
    uiSeq  : UINT;                // номер команды до сброса
END_VAR
