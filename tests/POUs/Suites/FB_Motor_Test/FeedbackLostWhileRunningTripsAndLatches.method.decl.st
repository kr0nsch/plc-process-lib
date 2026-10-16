// ОС пропала в работе: отказ FeedbackLost через tFbLossFilter = 500 мс (на 400 мс — ещё нет); отказ
// фиксируется — возврат ОС его не снимает, выходы остаются снятыми до Reset.
METHOD PRIVATE FeedbackLostWhileRunningTripsAndLatches
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
