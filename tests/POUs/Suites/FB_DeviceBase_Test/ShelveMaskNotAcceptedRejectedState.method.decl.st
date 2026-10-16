// Маска shelve, которую не принял ни один слот (у слота tShelveMax = 0; бит неиспользуемого слота),
// даёт результат RejectedState; слот остаётся ActiveUnack.
METHOD PRIVATE ShelveMaskNotAcceptedRejectedState
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // слот 1: shelve запрещён
    itfAlm   : I_Alarm;            // слот через интерфейс
END_VAR
