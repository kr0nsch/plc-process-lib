// xChannelFault (диагностика модуля, ошибка обмена) при нормальном токе: ChannelFault, значение удерживается, через
// tFailDelay 2 с — Failure и бит AI_FLT_CHANNEL; после снятия — возврат через те же 2 с.
METHOD PRIVATE ChannelFaultSetsFailure
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    iStep  : INT;                 // шаг цикла
END_VAR
