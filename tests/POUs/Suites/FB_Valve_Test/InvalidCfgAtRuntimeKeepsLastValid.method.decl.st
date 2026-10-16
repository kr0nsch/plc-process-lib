// Cfg испорчена в ходе (tTravel = 0): бит wCfgErr и CheckFunction, ход продолжается по последней
// корректной Cfg; время хода контролируется по ней же: FailToOpen ровно на t0 + 10 с.
METHOD PRIVATE InvalidCfgAtRuntimeKeepsLastValid
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
