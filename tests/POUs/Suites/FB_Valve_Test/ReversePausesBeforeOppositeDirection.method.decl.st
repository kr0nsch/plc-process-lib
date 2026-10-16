// Motorized открывается; команда «закрыть» в ходе: Reversing, оба выхода сняты на tReverse = 1 с (на
// t1 + 0,9 с ещё сняты), ровно на t1 + 1,0 с включается xQClose.
METHOD PRIVATE ReversePausesBeforeOppositeDirection
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
    xEverOn  : BOOL;              // выход включался во время паузы
END_VAR
