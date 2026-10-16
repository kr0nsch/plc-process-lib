// ПЧ не готов (xVfdReady = FALSE при связи): пуск оператора — RejectedPermit, бит PERMIT_MISSING; в Auto запрос
// ждёт (ReadyToStart = FALSE) и пуск происходит, когда ПЧ готов.
METHOD PRIVATE VfdNotReadyBlocksStart
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
