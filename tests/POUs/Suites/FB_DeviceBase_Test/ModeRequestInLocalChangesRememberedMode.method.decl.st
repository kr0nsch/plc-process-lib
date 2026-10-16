// В Local команда xSetAuto принимается и меняет только запомненный режим; после возврата
// переключателя устройство работает в Auto.
METHOD PRIVATE ModeRequestInLocalChangesRememberedMode
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
END_VAR
