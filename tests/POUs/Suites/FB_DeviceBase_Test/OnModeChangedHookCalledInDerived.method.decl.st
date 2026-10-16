// Вопрос R2 контракта: хук OnModeChanged, вызванный как THIS^.OnModeChanged из метода базы
// (ProcessMode, SwitchRemoteMode), выполняет переопределение наследника с параметрами смены.
METHOD PRIVATE OnModeChangedHookCalledInDerived
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
END_VAR
