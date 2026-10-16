// Manual: xStart принимается (Accepted, импульс сброшен), двигатель в Starting ждёт ОС; ОС через 2 с (меньше
// tFbStart = 5 с) — Running без отказа.
METHOD PRIVATE ManualStartFeedbackOkGoesRunning
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
