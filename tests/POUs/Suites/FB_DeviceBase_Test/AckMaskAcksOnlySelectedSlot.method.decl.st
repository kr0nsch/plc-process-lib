// Маска wAckReq квитирует только выбранный слот (бит 1), маска обнуляется, результат Accepted.
METHOD PRIVATE AckMaskAcksOnlySelectedSlot
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    itfAlm   : I_Alarm;            // слот через интерфейс
END_VAR
