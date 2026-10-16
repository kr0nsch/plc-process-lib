// Manual, открыта, разрешения на закрытие нет (xClose — RejectedPermit). Блокировка (биты 3 и 4) ведёт в
// положение безопасности Closed без разрешения: Closing, бит INTERLOCKED, wInterlock, первопричина —
// младший бит 3. Команды — RejectedInterlock; новый бит первопричину не меняет. После снятия блокировки
// Manual остаётся закрытым; первопричина держится до Reset.
METHOD PRIVATE InterlockDrivesToSafePosition
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
