// Cfg испорчена в работе (rKp := -1): CheckFunction, бит PID_CFG_KP, режим Auto сохраняется,
// регулирование идёт по последней корректной копии (Kp = 2).
METHOD PRIVATE InvalidCfgAtRuntimeKeepsLastValidCfg
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
END_VAR
