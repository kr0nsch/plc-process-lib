// Чек-лист, пункт 5: вход в OutOfService (хук OnModeChanged) снимает зафиксированный отказ и первопричину;
// тревоги — OutOfService, NE 107 — CheckFunction.
METHOD PRIVATE OosEntryClearsLatchedFaultsAndFirstOut
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    itfAlm   : I_Alarm;           // тревога слота
END_VAR
