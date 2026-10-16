// TorqueTrip, Reset при сработавшей муфте: отказ держится; муфта отпустила через 1 с — отказ снят в окне
// tResetWindow без второго результата (и после конца окна RejectedFault нет).
METHOD PRIVATE ResetCauseClearsWithinWindowFaultCleared
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
    uiSeq    : UINT;              // номер команды после Reset
END_VAR
