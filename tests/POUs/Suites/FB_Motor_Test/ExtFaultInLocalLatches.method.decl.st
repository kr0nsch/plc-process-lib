// Внешняя авария действует и в Local: отказ фиксируется (Fault); после возврата в Manual отказ остаётся,
// пуск — RejectedFault.
METHOD PRIVATE ExtFaultInLocalLatches
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
