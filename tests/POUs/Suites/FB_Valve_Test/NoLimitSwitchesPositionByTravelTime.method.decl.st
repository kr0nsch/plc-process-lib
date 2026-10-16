// Концевиков нет: старт — Unknown (VLV_WRN_POSITION_UNKNOWN). xOpen: выход держится tTravel = 10 с (на
// 9,9 с ещё Opening), ровно на 10,0 с — Open по времени без отказа, VLV_WRN_POSITION_BY_TIME; входы
// неподключённых концевиков не учитываются.
METHOD PRIVATE NoLimitSwitchesPositionByTravelTime
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
