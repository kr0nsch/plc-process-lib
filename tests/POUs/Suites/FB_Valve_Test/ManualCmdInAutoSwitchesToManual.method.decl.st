// Auto, запрос «закрыть», закрыта. xOpen оператора: Manual (запоминается в stRetain), Opening, Accepted;
// запрос автоматики больше не действует. xStop в Auto: Manual и стоп.
METHOD PRIVATE ManualCmdInAutoSwitchesToManual
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
END_VAR
