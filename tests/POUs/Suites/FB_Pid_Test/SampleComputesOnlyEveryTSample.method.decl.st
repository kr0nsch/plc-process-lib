// Период расчёта tSample = 100 мс при вызовах раз в 10 мс: за 300 мс выход меняется ровно три
// раза (на расчётах), между ними держится; шаг расчёта в Sts — 100 мс.
METHOD PRIVATE SampleComputesOnlyEveryTSample
VAR
    fbTime    : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid     : FB_PID;            // ФБ под тестом
    stCmd     : ST_PidCmd;         // команды
    stRetain  : ST_DeviceRetain;   // режим: старт в Manual
    stCfg     : ST_PidCfg;         // конфигурация теста
    iStep     : INT;               // шаг цикла
    rPrev     : REAL;              // выход прошлого вызова
    uiChanges : UINT;              // сколько раз выход изменился
END_VAR
