// Одновременные запросы режима (xSetAuto, xSetManual, xSetOos и RequestMode(Auto)) — одна команда:
// побеждает OutOfService; затем xSetAuto вместе с RequestMode(Manual) — побеждает Manual и выводит
// из OutOfService. Импульсы сброшены.
METHOD PRIVATE ConflictingModeRequestsOosWins
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    xRet     : BOOL;               // ответ RequestMode
END_VAR
