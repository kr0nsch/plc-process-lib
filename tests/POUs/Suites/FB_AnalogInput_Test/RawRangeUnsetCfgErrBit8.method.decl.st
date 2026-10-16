// Raw с не заданной шкалой отсчётов (умолчания 0/0): бит 8 wCfgErr (AI_CFG_RAW_RANGE) и только он, CheckFunction,
// безопасное значение 0.0, xValid = FALSE, Available = FALSE. После задания шкалы отсчётов Cfg принимается: 5000 из
// 0..10000 — 50 % шкалы 0..100.
METHOD PRIVATE RawRangeUnsetCfgErrBit8
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
