// Motorized открывается; xStop в ходе — Intermediate, выходы сняты, Accepted, бит сброшен. Цель Manual
// «никуда»: арматура стоит и дальше.
METHOD PRIVATE StopMotorizedGoesIntermediate
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
    xEverOn  : BOOL;              // выход включался после стопа
END_VAR
