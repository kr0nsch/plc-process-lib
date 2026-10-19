// OutOfService устройства — OutOfService у всех используемых слотов (3); в wAlmShelved и wAlmSuppressed их нет
// (ALM-2: вывод из работы виден по eMode), неквитированных нет; после выхода активная тревога снова ActiveUnack.
METHOD PRIVATE AlarmsInOosAllSlotsOutOfService
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    itfAlm   : I_Alarm;            // слот через интерфейс
END_VAR
