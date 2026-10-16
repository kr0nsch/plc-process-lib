// Manual: выход оператора ограничивается rOutMin_pct…rOutMax_pct (таблица 17.5), флаги насыщения
// выставляются и на самих пределах; значение оператора в Cmd ФБ не переписывает.
METHOD PRIVATE ManualOutputClampedToLimits
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим
    stCfg    : ST_PidCfg;         // конфигурация теста
    rOutHi   : REAL;              // выход при 95 %
    xSatHi   : BOOL;              // xSatHigh при 95 %
    rOutLo   : REAL;              // выход при 5 %
    xSatLo   : BOOL;              // xSatLow при 5 %
END_VAR
