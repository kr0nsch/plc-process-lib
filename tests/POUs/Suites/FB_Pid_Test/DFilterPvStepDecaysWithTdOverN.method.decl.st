// Фильтр Д (Td = 5 с, N = 10, Tf = 0,5 с, шаг 100 мс): после ступени PV составляющая D затухает
// множителем Tf/(Tf + dt) за шаг; через Tf от неё остаётся (5/6)^5, около 0,40.
METHOD PRIVATE DFilterPvStepDecaysWithTdOverN
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    rD1      : REAL;              // D сразу после ступени
END_VAR
