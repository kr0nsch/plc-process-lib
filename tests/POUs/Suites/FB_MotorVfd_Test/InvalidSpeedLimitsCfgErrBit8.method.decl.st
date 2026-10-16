// Пределы скорости неверны (min >= max, max > 100, min < 0): бит 8 MOT_CFG_VFD_SPEED_LIMITS (переопределение
// CheckConfig вызывается и из тела FB_Motor), CheckFunction.
METHOD PRIVATE InvalidSpeedLimitsCfgErrBit8
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
