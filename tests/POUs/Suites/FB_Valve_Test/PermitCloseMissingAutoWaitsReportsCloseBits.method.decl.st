// Auto, задвижка открыта. Нет разрешения на закрытие (бит 1), а на открытие не хватает другого бита
// (бит 0). Автоматика просит «закрыть»: выход «закрывать» не включается, бит PERMIT_MISSING, в
// wPermitMissing — недостающие биты направления к цели (16#0002), а не открытия. Разрешение появилось —
// задвижка закрывается, wPermitMissing = 0.
METHOD PRIVATE PermitCloseMissingAutoWaitsReportsCloseBits
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим: Auto
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
END_VAR
