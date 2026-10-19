// Auto, tMinRun = 10 с: через 2 с работы запрос снят — двигатель работает до tMinRun. Время назад на 30 с: отсчёт
// tMinRun начинается заново (M-17), двигатель не останавливается раньше срока; останов ровно через 10 с после скачка.
METHOD PRIVATE TimeBackwardsDuringMinRunKeepsRunning
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация
END_VAR
