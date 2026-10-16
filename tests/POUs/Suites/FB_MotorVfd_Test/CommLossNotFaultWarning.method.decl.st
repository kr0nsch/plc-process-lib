// xCommLossIsFault = FALSE (пуск/стоп и ОС проводами, xFbFromComm = FALSE): потеря связи — только
// предупреждение COMM_LOSS, NE 107 OutOfSpecification и тревога слота 6; двигатель работает, ОС по DI
// контролируется.
METHOD PRIVATE CommLossNotFaultWarning
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    itfAlm   : I_Alarm;           // тревога слота
END_VAR
