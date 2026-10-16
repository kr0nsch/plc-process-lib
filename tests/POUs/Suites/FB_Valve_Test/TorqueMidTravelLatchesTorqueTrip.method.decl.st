// Муфта подключена. Через 3 с хода, до концевика, сработала муфта открытия — TorqueTrip (wFault бит 4),
// выход снят, бит TORQUE. Муфта отпустила — отказ держится (бит TORQUE снят); Reset снимает отказ,
// арматура в промежутке стоит (Manual).
METHOD PRIVATE TorqueMidTravelLatchesTorqueTrip
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
