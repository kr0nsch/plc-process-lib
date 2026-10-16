// Local: выходы сняты, состояние следует ОС (Running/Stopped), контроля ОС нет (ни FailToStop, ни
// UncommandedRun), команды оператора — RejectedMode, блокировка — только предупреждение INTERLOCK_IN_LOCAL.
METHOD PRIVATE LocalModeOutputsOffTracksFeedback
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
