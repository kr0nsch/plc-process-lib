// Manual: «Пуск» во время выбега (Stopping) принят — двигатель запустится после останова (M-09). За время
// выбега пропало разрешение: после останова отложенный пуск отменяется (защёлка снята, второй результат
// RejectedPermit), и когда разрешение вернётся через 10 мин, двигатель в Manual сам не запускается.
METHOD PRIVATE StartWhileStoppingPermitLostCancelsLatch
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
