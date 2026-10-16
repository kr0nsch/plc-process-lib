// OutOfService: оба слота OutOfService (wAlmShelved = 2#11), значение удерживается (TRUE), xValid = FALSE,
// CheckFunction; отказ канала в OOS не даёт Failure; слежение xSubstValue действует и в OOS (2.1). После выхода
// активная тревога State снова ActiveUnack.
METHOD PRIVATE OutOfServiceAlarmsOutOfService
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDi   : FB_DigitalInput;      // ФБ под тестом
    stCmd  : ST_DigitalInputCmd;   // команды
    stCfg  : ST_DigitalInputCfg;   // конфигурация
    itfAlm : I_Alarm;              // слот тревоги через интерфейс
END_VAR
