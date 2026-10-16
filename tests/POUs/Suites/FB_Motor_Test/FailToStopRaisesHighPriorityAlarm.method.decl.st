// ОС не пропала после «Стоп»: отказ FailToStop через tFbStop = 5 с; тревога слота 2 — приоритет High
// (механизм не остановить из ПЛК), в сводке ePrioUnack = High, активен только слот 2.
METHOD PRIVATE FailToStopRaisesHighPriorityAlarm
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    itfAlm   : I_Alarm;           // тревога слота
END_VAR
