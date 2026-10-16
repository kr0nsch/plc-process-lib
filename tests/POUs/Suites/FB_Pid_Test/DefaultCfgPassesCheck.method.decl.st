// Значения ST_PidCfg по умолчанию проходят CheckConfig (инвариант генератора iolistgen, контракт
// 2.3): wCfgErr = 0, бита CFG_ERROR нет, статус Good в Manual.
METHOD PRIVATE DefaultCfgPassesCheck
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: Manual
    stCfg    : ST_PidCfg;         // конфигурация по умолчанию
END_VAR
