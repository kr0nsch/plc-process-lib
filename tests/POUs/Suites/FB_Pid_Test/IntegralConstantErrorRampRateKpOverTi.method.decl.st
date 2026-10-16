// ПИ-регулятор (Kp = 2, Ti = 10 с) при постоянной ошибке 4 %: выход растёт со скоростью
// Kp·e/Ti = 0,8 %/с, интегратор — на Kp·dt/Ti·e за шаг.
METHOD PRIVATE IntegralConstantErrorRampRateKpOverTi
VAR
    fbTime    : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid     : FB_PID;            // ФБ под тестом
    stCmd     : ST_PidCmd;         // команды
    stRetain  : ST_DeviceRetain;   // режим: старт в Manual
    stCfg     : ST_PidCfg;         // конфигурация теста
    iStep     : INT;               // шаг цикла
    rOutFirst : REAL;              // выход в первом шаге с ошибкой
END_VAR
