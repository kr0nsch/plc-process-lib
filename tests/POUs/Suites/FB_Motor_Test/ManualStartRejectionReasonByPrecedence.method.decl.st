// Причина отказа xStart в Manual — по старшинству 13.5: при отказе, блокировке, нет разрешения и паузе —
// RejectedFault; без отказа — RejectedInterlock; без блокировки — RejectedPermit; затем RejectedInhibit.
METHOD PRIVATE ManualStartRejectionReasonByPrecedence
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
