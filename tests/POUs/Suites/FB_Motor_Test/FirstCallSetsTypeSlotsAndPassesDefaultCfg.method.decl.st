// Чек-лист устройства, пункты 1 и 4: первый вызов — тип Motor, 8 слотов тревог, умолчания Cfg проходят
// CheckConfig; двигатель стоит, первопричины нет, NE 107 — Good (Manual у двигателя — не CheckFunction).
METHOD PRIVATE FirstCallSetsTypeSlotsAndPassesDefaultCfg
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
