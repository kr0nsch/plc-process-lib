// Local: выходы сняты, команды — RejectedMode; состояние по концевикам при движении руками (цикл
// считается); блокировка — только предупреждение VLV_WRN_INTERLOCK_IN_LOCAL; «оба концевика» не
// контролируется (Unknown, без отказа). Возврат в запомненный Manual без движения.
METHOD PRIVATE LocalOutputsOffTracksLimits
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
