// Сводный NE 107 = MAX(устройство, режим, Cfg): S и M от устройства (бит предупреждения), M при
// испорченной Cfg — C, F в OutOfService — F (Fault, бит отказа), Good в OutOfService — C;
// AI/DI-подобное устройство: Manual (подмена) — C.
METHOD PRIVATE SummaryStatusMaxOfDeviceModeAndCfg
VAR
    fbTime     : FB_FakeTime;        // подменное время
    fbDev      : FB_TestDevice;      // устройство под тестом
    stCmd      : ST_TestDeviceCmd;   // команды
    stRetain   : ST_DeviceRetain;    // энергонезависимые данные
    stCfg      : ST_TestDeviceCfg;   // конфигурация
    fbIn       : FB_TestDevice;      // AI/DI-подобное устройство
    stCmdIn    : ST_TestDeviceCmd;   // его команды
    stRetainIn : ST_DeviceRetain;    // его retain (не используется)
END_VAR
