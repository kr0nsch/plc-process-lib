// П-регулятор (Kp = 2, без I и D): после безударного перехода в Auto со смещением 40 % выход
// отличается от смещения ровно на Kp·e при ошибке +5 % и -3 %.
METHOD PRIVATE POnlyErrorStepOutputEqualsKpTimesError
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
END_VAR
