// Безударный переход Auto → Manual (хук наследника): работающий механизм продолжает работать.
METHOD PRIVATE AutoToManualBumplessKeepsOutput
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
END_VAR
