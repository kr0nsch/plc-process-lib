// Внешняя авария через фильтр tExtFaultFilter = 200 мс: отказ ExtFault, выходы сняты. Reset при действующей
// причине: Accepted и импульс xQReset сразу, к концу окна tResetWindow = 3 с — второй результат RejectedFault,
// отказ остаётся.
METHOD PRIVATE ExtFaultTripsAndResetRejectedWhileActive
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    uiSeqExp : UINT;              // ожидаемый номер команды
END_VAR
