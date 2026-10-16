// Manual, задвижка закрыта (ZSC). xOpen: Opening, включён только xQOpen, остаток хода 10 с; через 2 с
// остаток 8 с; ZSO на t0 + 5,0 с — Open, выход снят, xOpened, один цикл в stRetain.
METHOD PRIVATE OpenLimitReachedGoesOpen
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
