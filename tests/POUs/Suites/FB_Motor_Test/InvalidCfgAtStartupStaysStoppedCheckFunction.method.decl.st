// Неверная Cfg с первого вызова (uiMaxStartsPerHour > STARTS_WINDOW_MAX): бит MOT_CFG_STARTS_LIMIT,
// CheckFunction, безопасный выход — запрос Auto не запускает, Available = FALSE, xStart — RejectedCfg.
METHOD PRIVATE InvalidCfgAtStartupStaysStoppedCheckFunction
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
