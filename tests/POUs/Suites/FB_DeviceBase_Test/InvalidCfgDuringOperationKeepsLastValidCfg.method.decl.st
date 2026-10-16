// Cfg испорчена в работе (rGain = -1): бит wCfgErr и CheckFunction, но логика работает по LKG
// (значение 20 от rGain = 2), механизм не останавливается, Available не меняется; исправленная
// Cfg (rGain = 3) принимается сразу.
METHOD PRIVATE InvalidCfgDuringOperationKeepsLastValidCfg
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // rGain = 2, затем -1 и 3
END_VAR
