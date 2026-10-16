// «Время назад» на 30 с (источник времени переставлен): LTIME без знака, разность не считается;
// шаг инициализации — выход прежний, бит DT_GAP; дальше интегрирование по обычному шагу.
METHOD PRIVATE TimeBackwardsInitStepNoJump
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    rBefore  : REAL;              // выход до скачка времени
    rBack    : REAL;              // выход в вызове после скачка
    wStsBack : WORD;              // wStatus в вызове после скачка
    rAfter   : REAL;              // выход в следующем вызове
END_VAR
