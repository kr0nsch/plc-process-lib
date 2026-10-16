// Пределы выхода 10…90 % (Kp = 2, без I): большая положительная ошибка — выход 90 % и xSatHigh
// (бит SAT_HIGH), большая отрицательная — 10 % и xSatLow (бит SAT_LOW).
METHOD PRIVATE OutputLimitsClampAndFlags
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
END_VAR
