// stRetain.xOutOfService = TRUE после перезапуска: устройство стартует в OutOfService (хук — в
// первом вызове), все слоты тревог OutOfService; xSetAuto выводит из OutOfService.
METHOD PRIVATE OutOfServiceRetainedStartsInOos
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // OutOfService сохранён
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    itfAlm   : I_Alarm;            // слот через интерфейс
END_VAR
