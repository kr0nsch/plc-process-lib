// Расчёт по реальному dt (Kp = 2, Ti = 10 с, e = 4 %): за 5 с при вызовах раз в 10 мс и раз в
// 100 мс интегратор одинаков (30 + 2·4·5/10 = 34 %). Выход берёт интегратор прошлого шага,
// поэтому выходы различаются ровно на приращение одного шага: 0,008 и 0,08 %.
METHOD PRIVATE RealDtSameResultFor10msAnd100msSteps
VAR
    fbTimeA  : FB_FakeTime;       // время ФБ A (шаг 10 мс)
    fbTimeB  : FB_FakeTime;       // время ФБ B (шаг 100 мс)
    fbPidA   : FB_PID;            // вызовы раз в 10 мс
    fbPidB   : FB_PID;            // вызовы раз в 100 мс
    stCmdA   : ST_PidCmd;         // команды
    stCmdB   : ST_PidCmd;
    stRetA   : ST_DeviceRetain;   // режим: старт в Manual
    stRetB   : ST_DeviceRetain;
    stCfg    : ST_PidCfg;         // общая конфигурация
    iStep    : INT;               // шаг цикла
END_VAR
