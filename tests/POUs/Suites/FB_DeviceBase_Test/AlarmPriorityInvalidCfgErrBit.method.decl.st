// Приоритет тревоги вне перечисления (9) не проходит CheckAlarmCfg: бит wCfgErr устройства и
// CheckFunction; исправленный приоритет снимает бит.
METHOD PRIVATE AlarmPriorityInvalidCfgErrBit
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // слот 3: приоритет 9
    uBad     : U_TestEnumInt;      // число вне перечисления
END_VAR
