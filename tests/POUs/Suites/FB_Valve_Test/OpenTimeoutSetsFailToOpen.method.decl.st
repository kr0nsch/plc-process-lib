// tTravel = 10 с, ZSO не приходит: на t0 + 9,9 с ещё Opening без отказа, ровно на t0 + 10,0 с —
// FailToOpen (wFault бит 0, Failure, тревога слота 0), выход снят. Отказ фиксируется: пришедший позже
// ZSO его не снимает (положение видно в xOpened), снимает Reset — далее состояние по концевикам.
METHOD PRIVATE OpenTimeoutSetsFailToOpen
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
    itfAlm   : I_Alarm;           // слот тревоги через интерфейс
END_VAR
