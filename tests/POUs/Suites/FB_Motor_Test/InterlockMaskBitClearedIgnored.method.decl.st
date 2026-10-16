// Бит блокировки, снятый в wInterlockMask, не действует: двигатель работает, в wInterlock состояния его нет,
// первопричины нет; немаскированный бит останавливает (первопричина — он).
METHOD PRIVATE InterlockMaskBitClearedIgnored
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
