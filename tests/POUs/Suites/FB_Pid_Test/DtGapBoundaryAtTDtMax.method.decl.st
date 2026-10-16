// Граница разрыва времени (tDtMax = 1 с): шаг ровно 1 с — обычный расчёт (dt = 1000 мс, интеграл
// +0,8 %, без DT_GAP), шаг 1,001 с — разрыв: шаг инициализации, выход прежний, интегратор
// предустановлен I := u - P (30,8 %), бит DT_GAP. Условие контракта — «dt > tDtMax».
METHOD PRIVATE DtGapBoundaryAtTDtMax
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    rIBefore : REAL;              // интегратор до длинных шагов
    rIAtMax  : REAL;              // интегратор после шага ровно tDtMax
    rDtAtMax : REAL;              // stSts.rDt_ms после шага ровно tDtMax
    wStsMax  : WORD;              // wStatus после шага ровно tDtMax
    rOutMax  : REAL;              // выход после шага ровно tDtMax
END_VAR
