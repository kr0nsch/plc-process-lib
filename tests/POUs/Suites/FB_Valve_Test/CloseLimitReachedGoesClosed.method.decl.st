// Manual, задвижка открыта (ZSO). xClose: Closing, включён только xQClose; ZSC на t0 + 3,0 с — Closed,
// выход снят, xClosed. Закрытие циклом «открыто» не считается.
METHOD PRIVATE CloseLimitReachedGoesClosed
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
