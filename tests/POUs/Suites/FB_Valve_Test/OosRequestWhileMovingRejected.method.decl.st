// Вывод из работы в ходе — RejectedState, ход продолжается. Остановленную арматуру вывести можно:
// OutOfService, выходы сняты, CheckFunction, команды — RejectedMode.
METHOD PRIVATE OosRequestWhileMovingRejected
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
END_VAR
