// Старт ПЛК с режимом Auto в stRetain: ФБ стартует в Auto (хук в первом вызове), выход — из
// stCmd.rManualOut_pct (42 %), интегратор инициализирован шагом инициализации (бит DT_GAP первого
// вызова), дальше регулирование без рывка.
METHOD PRIVATE RetainAutoRestoredOnRestart
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом (новый экземпляр = после перезапуска)
    stCmd    : ST_PidCmd;         // команды (GVL_Hmi переживает загрузку как Persistent)
    stRetain : ST_DeviceRetain;   // режим Auto из Persistent Variables
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    rOutSt   : REAL;              // выход первого вызова
    wStsSt   : WORD;              // wStatus первого вызова
END_VAR
