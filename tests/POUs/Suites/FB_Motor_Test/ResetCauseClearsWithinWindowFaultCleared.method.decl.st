// Reset при действующей причине, причина уходит через 1 с (в окне tResetWindow = 3 с): отказ снимается без
// второго нажатия, двигатель Stopped; RejectedFault в конце окна не появляется.
METHOD PRIVATE ResetCauseClearsWithinWindowFaultCleared
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    uiSeqExp : UINT;              // номер команды после Reset
END_VAR
