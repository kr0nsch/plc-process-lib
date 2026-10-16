// PresetCounters() только ставит запрос (TRUE), значения пишет ближайший вызов тела: наработка и пуски в
// stRetain, RunSeconds, Starts, rRunTime_h = 100 ч, Accepted; счётчики «с ТО» не меняются.
METHOD PRIVATE PresetCountersAppliedInBody
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
