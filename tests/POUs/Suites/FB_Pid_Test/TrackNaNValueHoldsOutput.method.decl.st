// Слежение за неконечным значением (NaN из образа обмена): выход и слежение в Cmd остаются
// прежними, NaN на механизм не уходит; конечное значение снова принимается.
METHOD PRIVATE TrackNaNValueHoldsOutput
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим
    stCfg    : ST_PidCfg;         // конфигурация теста
    uBits    : U_RealBits;        // источник NaN
    rOutNaN  : REAL;              // выход при NaN
    rCmdNaN  : REAL;              // stCmd.rManualOut_pct при NaN
END_VAR
