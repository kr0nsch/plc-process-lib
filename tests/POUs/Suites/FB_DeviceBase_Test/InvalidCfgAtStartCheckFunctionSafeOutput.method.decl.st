// Корректной Cfg ещё не было (rGain = 0): бит wCfgErr, NE 107 CheckFunction, DEV_STS_CFG_ERROR,
// безопасный выход (FALSE и в Auto с запросом), Available = FALSE, пуск — RejectedCfg; режимы
// работают.
METHOD PRIVATE InvalidCfgAtStartCheckFunctionSafeOutput
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // rGain = 0 — неверно
END_VAR
