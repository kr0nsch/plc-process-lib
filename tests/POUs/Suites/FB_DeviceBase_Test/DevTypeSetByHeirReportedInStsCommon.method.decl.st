// Тип устройства задаёт наследник в первом вызове, FinishCycle пишет его в stCommon.eDevType;
// до первого вызова — None.
METHOD PRIVATE DevTypeSetByHeirReportedInStsCommon
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
END_VAR
