// Зафиксированные TorqueTrip (муфта в ходе, отпустила) и внешняя авария (причина ушла) снимаются входом в
// OutOfService; в OOS внешняя авария не контролируется, тревоги — OutOfService; после выхода в Manual
// отказа нет.
METHOD PRIVATE OosEntryClearsLatchedFaults
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    itfAlm   : I_Alarm;           // слот тревоги через интерфейс
END_VAR
