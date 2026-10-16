// Связи с ПЧ нет с первого вызова: ResolveTime() до вложенного фильтра даёт подменное время и в первом
// вызове, отказ связи — ровно через tCommLoss = 2 с (на 1,9 с ещё нет).
METHOD PRIVATE FirstCallFakeTimeCommLossDeterministic
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
