// SwitchRemoteMode в Local меняет только запомненный режим, без смены режима и хука; после возврата
// переключателя — Manual.
METHOD PRIVATE SwitchRemoteModeInLocalOnlyRemembers
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    uiHooks  : UINT;               // вызовов хука до SwitchRemoteMode
END_VAR
