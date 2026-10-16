// Ограничение скорости выхода 5 %/с (Kp = 2, Ti = 10 с): после ступени задания на 10 % выход
// растёт ровно на 0,5 % за шаг 100 мс (бит OUT_RATE_LIMITED), а обратный расчёт по разности
// u - v сдерживает интегратор (без него было бы 40 + 2·10·2/10 = 44 % за 2 с).
METHOD PRIVATE OutputRateLimitIntegratorBacksOff
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
END_VAR
