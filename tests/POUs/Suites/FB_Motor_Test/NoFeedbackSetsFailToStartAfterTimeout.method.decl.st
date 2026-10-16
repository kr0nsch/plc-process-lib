// Нет ОС после пуска: отказ FailToStart ровно через tFbStart = 5 с (на 4,9 с — ещё нет), выходы сняты, Fault,
// NE 107 Failure, тревога слота 0 активна и не квитирована.
METHOD PRIVATE NoFeedbackSetsFailToStartAfterTimeout
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    itfAlm   : I_Alarm;           // тревога слота
END_VAR
