// Связь пропала во время пуска (tFbStart = 2 с) на 2,4 с — меньше tCommLoss: FailToStart не формируется,
// состояние Starting удерживается; связь вернулась с ОС — Running без отказа.
METHOD PRIVATE CommLossSuppressesFeedbackSupervisionImmediately
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
