// «Время назад» (SetNow на 30 с раньше) у работающего двигателя: отказов нет, наработка не скачет (шаг
// времени 0), дальше считается обычно.
METHOD PRIVATE TimeBackwardsNoFaultNoCountJump
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
