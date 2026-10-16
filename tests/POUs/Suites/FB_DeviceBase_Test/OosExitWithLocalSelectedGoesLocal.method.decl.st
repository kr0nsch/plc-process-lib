// OutOfService старше Local: при переключателе «Местное» устройство остаётся OutOfService; выход из
// OutOfService командой xSetManual при включённом «Местном» — в Local.
METHOD PRIVATE OosExitWithLocalSelectedGoesLocal
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
END_VAR
