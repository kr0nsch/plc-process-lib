// Клиновая задвижка: муфта подключена, закрытие «по моменту». Через 3 с хода сработал ZSC (стоит чуть
// раньше посадки клина) — выход держится; через 0,2 с клин сел, сработала муфта закрытия — Closed без
// отказа, выход снят, xClosed; предупреждения «положение по времени» нет. Муфта отпустила, ZSC держится —
// задвижка остаётся Closed без отказа. Муфта раньше ZSC — тест
// Valve_CloseOnTorque_TorqueBeforeZsc_LatchesTorqueTrip.
METHOD PRIVATE CloseOnTorqueCompletesClosing
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
