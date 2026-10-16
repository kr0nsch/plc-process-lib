// Умолчания ST_ValveCfg проходят CheckConfig; тип в stCommon — Valve, слотов тревог 7; приоритеты по
// умолчанию (FailToOpen — Medium, InterlockAct — None); слот 7 не используется; NE 107 Good.
METHOD PRIVATE DefaultCfgPassesCheck
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    itfAlm   : I_Alarm;           // слот тревоги через интерфейс
END_VAR
