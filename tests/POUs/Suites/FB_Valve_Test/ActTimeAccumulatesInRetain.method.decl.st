// Время работы привода: 12,5 с с включённым выходом — 12 с в stRetain (доля 0,5 с в накопителе), часы в
// Sts; пока стоит — не копится; шаг времени 60 с идёт в счёт не больше DT_ACCUM_MAX = 10 с.
METHOD PRIVATE ActTimeAccumulatesInRetain
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
