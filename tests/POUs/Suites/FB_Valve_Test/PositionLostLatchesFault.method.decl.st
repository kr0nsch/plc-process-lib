// Manual, открыта. Провал ZSO на 0,4 с фильтруется (tLimitFilter = 0,5 с). Пропал на 0,5 с без команды —
// PositionLost (wFault бит 3), фиксируется: вернувшийся ZSO отказ не снимает, снимает Reset.
METHOD PRIVATE PositionLostLatchesFault
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
