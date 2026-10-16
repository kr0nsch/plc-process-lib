// Зона нечувствительности 1 % (Kp = 2, Ti = 10 с): ошибка 0,8 % — e' = 0, выход и интегратор
// стоят 2 с, бит IN_DEADBAND; ошибка 1,5 % — e' = 0,5 %, выход +1 % без скачка на границе зоны.
METHOD PRIVATE DeadbandNoActionInsideBand
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    rOutIn   : REAL;              // выход в зоне
    rErrIn   : REAL;              // e' в зоне
    wStsIn   : WORD;              // wStatus в зоне
END_VAR
