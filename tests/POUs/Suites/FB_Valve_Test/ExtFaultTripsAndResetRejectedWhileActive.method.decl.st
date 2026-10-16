// Внешняя авария в ходе: Fault, выход снят, тревога слота 5 с номером udiAlarmIdBase + 5. Reset при
// действующей причине: Accepted сразу, окно tResetWindow = 3 с; до конца окна второго результата нет,
// ровно на 3 с — RejectedFault, отказ остаётся. Причина ушла — отказ держится до Reset; Reset снимает.
METHOD PRIVATE ExtFaultTripsAndResetRejectedWhileActive
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
    itfAlm   : I_Alarm;           // слот тревоги через интерфейс
    uiSeq    : UINT;              // номер команды до Reset
END_VAR
