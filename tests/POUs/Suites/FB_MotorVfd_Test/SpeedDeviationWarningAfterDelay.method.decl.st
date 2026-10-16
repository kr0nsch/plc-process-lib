// Рассогласование задания 50 % и факта 35 % (больше rSpeedDev_pct = 10 %) дольше tSpeedDev = 10 с:
// предупреждение SPEED_DEV, NE 107 OutOfSpecification, тревога слота 7; не отказ — двигатель работает.
METHOD PRIVATE SpeedDeviationWarningAfterDelay
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    itfAlm   : I_Alarm;           // тревога слота
END_VAR
