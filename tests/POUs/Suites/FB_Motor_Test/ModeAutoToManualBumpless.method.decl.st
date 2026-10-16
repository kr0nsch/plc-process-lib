// Auto → Manual при работе: ручная защёлка := команда работы, двигатель продолжает работать; снятие xAutoRun в
// Manual его не останавливает.
METHOD PRIVATE ModeAutoToManualBumpless
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
