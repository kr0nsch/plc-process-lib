// RequestMode() — запрос, как бит stCmd: режим меняет ближайший вызов тела, результат и uiCmdSeq —
// как у команды; OutOfService при движущемся механизме — RejectedState и через метод, и через бит.
METHOD PRIVATE RequestModeSameEffectAsCmd
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    xRet     : BOOL;               // ответ RequestMode
END_VAR
