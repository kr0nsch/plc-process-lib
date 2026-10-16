// Нет разрешения на открытие (бит 0): xOpen — RejectedPermit, движения нет; бит снят из маски —
// команда принята. В Auto запрос «открыть» ждёт разрешения (бит PERMIT_MISSING, wPermitMissing) и
// выполняется, когда оно появится.
METHOD PRIVATE PermitOpenMissingOpenRejected
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
END_VAR
