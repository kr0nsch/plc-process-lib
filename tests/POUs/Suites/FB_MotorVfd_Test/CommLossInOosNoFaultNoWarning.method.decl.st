// Отказ связи с ПЧ действует во всех режимах, кроме OutOfService (13.6, 14.4): в OOS связи нет 4 с — ни
// MOT_FLT_COMM_LOSS (xCommLossIsFault = TRUE), ни MOT_WRN_COMM_LOSS (FALSE), тревога слота 6 — в OutOfService.
// Выход в Manual при той же потере связи — предупреждение появляется.
METHOD PRIVATE CommLossInOosNoFaultNoWarning
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
