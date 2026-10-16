// Безопасное состояние при отказе: выход снят, Fault, NE 107 Failure, бит wFault, Available =
// FALSE. Reset при действующей причине — RejectedFault; причина ушла — отказ держится до Reset();
// после Reset() выход не включается сам (ручная защёлка снята).
METHOD PRIVATE FailureSafeStateResetRules
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    xRet     : BOOL;               // ответ Reset
END_VAR
