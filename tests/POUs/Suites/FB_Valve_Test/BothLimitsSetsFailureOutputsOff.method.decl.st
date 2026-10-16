// Auto, закрыта. Залип ZSO — оба концевика: до tLimitFilter (0,5 с) состояние держится, на 0,5 с —
// BothLimits (wFault бит 2, Failure, тревога слота 2). Запрос автоматики «открыть» выходы не включает,
// Available = FALSE. Отказ не фиксируется: концевик исправен — отказ снят без Reset, Auto ведёт к цели.
METHOD PRIVATE BothLimitsSetsFailureOutputsOff
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
    itfAlm   : I_Alarm;           // слот тревоги через интерфейс
END_VAR
