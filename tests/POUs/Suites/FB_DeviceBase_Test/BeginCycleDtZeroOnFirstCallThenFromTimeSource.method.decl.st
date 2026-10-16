// BeginCycle: в первом вызове ltDt = 0; затем — шаг подменного времени (250 мс); при «времени
// назад» — 0 (без переполнения LTIME); дальше снова шаг (100 мс).
METHOD PRIVATE BeginCycleDtZeroOnFirstCallThenFromTimeSource
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
END_VAR
