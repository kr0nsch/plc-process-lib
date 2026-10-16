// Чек-лист, пункты 1 и 8: тип MotorVfd (FB_Motor его не затирает), 8 слотов, умолчания Cfg с полем stVfd
// проходят CheckConfig, задание 0 %.
METHOD PRIVATE FirstCallSetsTypeMotorVfdAndPassesDefaultCfg
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
