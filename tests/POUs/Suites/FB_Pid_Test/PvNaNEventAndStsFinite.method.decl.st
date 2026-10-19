// Auto, PV = NaN при xPvValid = TRUE (мусор Modbus): тревога PvInvalid; значение её события и stSts.rPv_eu конечны —
// 0.0 (R6), выход удерживается (Hold) и конечен.
METHOD PRIVATE PvNaNEventAndStsFinite
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: Auto из Retain
    stCfg    : ST_PidCfg;         // конфигурация (умолчания)
    fbSink   : FB_TestSink;       // приёмник событий
    stEv     : ST_AlarmEvent;     // последнее событие
    uBits    : U_RealBits;        // NaN по битам
END_VAR
