// Reset без отказов (чек-лист, пункт 2): результат Accepted, uiCmdSeq + 1; импульс xQReset длится
// tResetPulse = 1 с (на 0,9 с ещё есть, на 1,0 с — нет); RejectedFault в конце окна нет.
METHOD PRIVATE ResetPulsesResetOutput
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    uiSeqExp : UINT;              // ожидаемый номер команды
END_VAR
