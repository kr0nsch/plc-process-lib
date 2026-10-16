// Все импульсные биты и маски stCmd (xSetAuto, xSetManual, xSetOos, xReset, xAck, wAckReq,
// wShelveReq, wUnshelveReq, xStart, xStop) сброшены в том же вызове.
METHOD PRIVATE CmdBitsClearedAfterProcessing
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
END_VAR
