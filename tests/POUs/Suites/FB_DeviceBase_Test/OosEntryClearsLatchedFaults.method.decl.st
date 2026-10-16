// Вход в OutOfService снимает зафиксированные отказы (хук наследника): отказ без Reset держится,
// после xSetOos — Fault = FALSE, статус CheckFunction, wFault = 0; после выхода в Manual — Good.
METHOD PRIVATE OosEntryClearsLatchedFaults
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
END_VAR
