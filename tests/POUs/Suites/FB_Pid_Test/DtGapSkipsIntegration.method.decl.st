// Разрыв времени 5 с > tDtMax = 2 с (стоп ПЛК, отладка): шаг инициализации — выход прежний,
// интегратор не получает 5 с (без защиты было бы +4 %), бит DT_GAP и предупреждение
// PID_WRN_DT_GAP на один вызов; дальше интегрирование по обычному шагу.
METHOD PRIVATE DtGapSkipsIntegration
VAR
    fbTime    : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid     : FB_PID;            // ФБ под тестом
    stCmd     : ST_PidCmd;         // команды
    stRetain  : ST_DeviceRetain;   // режим: старт в Manual
    stCfg     : ST_PidCfg;         // конфигурация теста
    iStep     : INT;               // шаг цикла
    rBefore   : REAL;              // выход до разрыва
    rGap      : REAL;              // выход в вызове после разрыва
    wStsGap   : WORD;              // wStatus в вызове после разрыва
    wWrnGap   : WORD;              // wWarning в вызове после разрыва
    rAfter    : REAL;              // выход в следующем вызове
    wStsAfter : WORD;              // wStatus в следующем вызове
END_VAR
