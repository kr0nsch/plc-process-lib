// Manual: отказ связи снимает ручную защёлку; связь вернулась, ПЧ ещё работает, запроса нет — штатный
// останов с контролем (Stopping, команда не подаётся), затем Stopped.
METHOD PRIVATE CommRestoredRunningWithoutDemandStops
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
