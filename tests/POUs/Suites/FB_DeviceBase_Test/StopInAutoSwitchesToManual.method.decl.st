// «Стоп» оператора в Auto: SwitchRemoteMode переводит в Manual сразу (хук Auto → Manual), режим
// записан в retain, механизм остановлен, результат Accepted.
METHOD PRIVATE StopInAutoSwitchesToManual
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
END_VAR
