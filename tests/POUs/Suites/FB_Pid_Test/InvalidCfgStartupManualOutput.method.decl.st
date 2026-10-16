// Корректной Cfg ещё не было (rKp = 0): расчёта нет, выход = LIMIT(0, rManualOut_pct, 100),
// CheckFunction, бит PID_CFG_KP, Available = FALSE; запрос Auto — RejectedCfg; слежения в Cmd
// нет (значение оператора не переписывается).
METHOD PRIVATE InvalidCfgStartupManualOutput
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // неверная конфигурация
END_VAR
