// Слежение при движущейся PV и Td > 0: D работает и при слежении (за 2 с выходит на 5 %), а
// предустановка I := u - P - D держит v = u. Снятие слежения — выход 30 % плюс изменение P и D за
// один шаг, без «удара» на величину D.
METHOD PRIVATE TrackPvMovingNoDerivativeKickAtRelease
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: Auto из Retain
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    rDTrk    : REAL;              // D в конце слежения
    rITrk    : REAL;              // I в конце слежения
    rOutTrk  : REAL;              // выход в конце слежения
END_VAR
