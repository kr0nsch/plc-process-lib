// Cfg испорчена в работе (tResetWindow = T#0S): двигатель продолжает работать, CheckFunction и бит
// MOT_CFG_RESET; логика — по последней корректной копии: фильтр пропадания ОС 500 мс, а не 5 с из новой Cfg.
METHOD PRIVATE InvalidCfgAtRuntimeKeepsRunningWithLastValid
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
