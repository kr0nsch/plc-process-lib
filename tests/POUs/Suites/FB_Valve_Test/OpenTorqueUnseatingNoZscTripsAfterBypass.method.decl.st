// Закрытие по моменту без ZSC (xZscUsed = FALSE): задвижка закрыта по муфте. «Открыть»: муфта открытия держится —
// при страгивании с закрытого положения она не контролируется VLV_UNSEAT_BYPASS = 2 с от начала хода (VLV-21);
// держится дольше — клин не вышел из седла: TorqueTrip ровно через 2 с, выход снят.
METHOD PRIVATE OpenTorqueUnseatingNoZscTripsAfterBypass
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
