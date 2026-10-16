// xUseOutAct, а фактический выход не конечен (связь с ПЧ потеряна, в образе обмена NaN): обратный
// расчёт идёт по собственному выходу ФБ, NaN в интегратор не попадает. Без насыщения член u - v
// равен нулю — выход тот же, что в сценарии integral.
METHOD PRIVATE AntiWindupOutActNaNUsesOwnOutput
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим
    stCfg    : ST_PidCfg;         // конфигурация теста
    uBits    : U_RealBits;        // источник NaN
    iStep    : INT;               // шаг цикла
    rOut1    : REAL;              // выход первого шага в Auto
END_VAR
