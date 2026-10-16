// Корректной Cfg ещё не было (tTravel = T#0S): бит VLV_CFG_TRAVEL, CheckFunction, DEV_STS_CFG_ERROR;
// Auto с запросом «открыть» — выходы сняты 1 с, Available = FALSE; состояние по концевикам; xOpen —
// RejectedCfg без смены режима. Cfg исправлена — арматура идёт к цели.
METHOD PRIVATE InvalidCfgStartupOutputsOff
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
    xEverOn  : BOOL;              // выход включался без корректной Cfg
END_VAR
