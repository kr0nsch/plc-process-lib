// Старт ПЛК (первый вызов, Manual): ZSO — Open, оба концевика — сразу Fault (BothLimits), ни одного —
// Intermediate, без концевиков — Unknown; выходы сняты.
METHOD PRIVATE PlcRestartStateFromLimits
VAR
    fbTime    : FB_FakeTime;       // подменное время
    fbOpen    : FB_Valve;          // старт на ZSO
    fbBoth    : FB_Valve;          // старт на обоих концевиках
    fbMid     : FB_Valve;          // старт без сигналов концевиков
    fbNone    : FB_Valve;          // старт без подключённых концевиков
    stCmd     : ST_ValveCmd;       // команды (общие: пустые)
    stRetain  : ST_DeviceRetain;   // Manual
    stCfg     : ST_ValveCfg;       // умолчания
    stCfgNone : ST_ValveCfg;       // концевики не подключены
END_VAR
