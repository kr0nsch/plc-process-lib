// ReadyToStart — «стоит и готов к пуску» (I_Motor): в Auto до пуска TRUE; в Starting (команда подана, ОС ещё
// нет, tMinStop = 0) — FALSE: станция не должна считать запускаемый насос резервом; в Running — FALSE.
METHOD PRIVATE ReadyToStartFalseWhileStarting
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
