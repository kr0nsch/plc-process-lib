// Local старше дистанционного режима: в Local выходы сняты, запомненный режим (Auto) сохранён;
// после возврата переключателя устройство продолжает в Auto. Хук — на каждой смене режима.
METHOD PRIVATE LocalOverridesRemoteReturnsToRememberedMode
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
END_VAR
