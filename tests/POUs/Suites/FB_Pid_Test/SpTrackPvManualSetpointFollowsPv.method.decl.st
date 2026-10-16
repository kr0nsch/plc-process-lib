// xSpTrackPv: в Manual задание следует за PV (ФБ пишет PV в stCmd.rSp_eu), поэтому переход в
// Auto идёт с нулевой ошибкой и выход не меняется.
METHOD PRIVATE SpTrackPvManualSetpointFollowsPv
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    rCmdSp   : REAL;              // stCmd.rSp_eu в Manual
    rOutSw   : REAL;              // выход в вызове перехода
END_VAR
