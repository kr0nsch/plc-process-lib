// Соленоид НЗ (SolenoidEto) открывается; xStop — RejectedNotSupported: катушка и движение не меняются,
// бит сброшен.
METHOD PRIVATE StopSolenoidRejected
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
END_VAR
