// Слежение в Auto при негодной PV: ПИД не регулирует, поэтому не Failure и wFault = 0; выход —
// rTrack_pct; тревога PvInvalid по контракту (PV негодна в Auto) активна.
METHOD PRIVATE TrackWithInvalidPvNoFailure
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: Auto из Retain
    stCfg    : ST_PidCfg;         // конфигурация по умолчанию
END_VAR
