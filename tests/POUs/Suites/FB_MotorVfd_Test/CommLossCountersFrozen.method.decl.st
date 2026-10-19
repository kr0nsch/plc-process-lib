// ПЧ с ОС из слова состояния работает в Auto 10 с; связь пропала на 1 ч (кабель), питание есть. Через tCommLoss —
// отказ CommLoss, и двигатель больше не считается работающим по устаревшей ОС (VFD-11): xRunning, Running и бит
// RUNNING сняты, наработка выросла только на время до отказа, CurrentRunSeconds = 0. Связь вернулась, ПЧ работает,
// запрос есть — Running без нового пуска.
METHOD PRIVATE CommLossCountersFrozen
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)

    udiRun0  : UDINT;             // наработка до потери связи, с
    udiCnt0  : UDINT;             // пусков до потери связи
END_VAR
