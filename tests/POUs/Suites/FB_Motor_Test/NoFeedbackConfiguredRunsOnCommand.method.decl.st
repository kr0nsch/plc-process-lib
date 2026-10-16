// Без ОС (xFbUsed = FALSE; tFbStart = T#0S тогда допустим): работа — по команде, сразу Running; отказов
// контроля ОС нет; наработка и пуски — по команде.
METHOD PRIVATE NoFeedbackConfiguredRunsOnCommand
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
