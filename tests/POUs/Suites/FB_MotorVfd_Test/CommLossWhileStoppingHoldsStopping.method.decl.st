// Связь с ПЧ пропала во время торможения (Stopping, ОС из слова состояния): ОС недостоверна — состояние
// удерживается в Stopping (не «остановлен»), контроль приостановлен; связь вернулась через 1 с (меньше
// tCommLoss), ПЧ ещё тормозит — Stopping под контролем tFbStop; ПЧ остановился — Stopped без отказа.
METHOD PRIVATE CommLossWhileStoppingHoldsStopping
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
