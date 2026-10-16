// FailToStop снимается Reset только когда двигатель не работает по ОС (M-02): Reset при ещё работающем
// двигателе — импульс xQReset, отказ остаётся, к концу окна tResetWindow = 3 с второй результат RejectedFault;
// ОС пропала — следующий Reset снимает отказ, двигатель в Stopped.
METHOD PRIVATE ResetFailToStopClearedOnlyAfterMotorStops
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
