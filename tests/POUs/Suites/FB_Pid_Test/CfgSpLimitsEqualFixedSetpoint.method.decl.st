// Равные пределы задания допустимы (бит 6 — только min > max): задание фиксировано, любое
// задание оператора ограничивается этим значением.
METHOD PRIVATE CfgSpLimitsEqualFixedSetpoint
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим
    stCfg    : ST_PidCfg;         // конфигурация теста
END_VAR
