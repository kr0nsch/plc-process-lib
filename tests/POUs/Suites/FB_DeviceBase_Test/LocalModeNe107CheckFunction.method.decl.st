// Local (переключатель на месте, тип с Local): ПЛК механизмом не управляет — сводный NE 107 CheckFunction («местное
// управление», категория C NE 107, статус PA 0x3C), Available = FALSE; отказ в Local старше — Failure. Возврат в
// дистанционный режим — Good.
METHOD PRIVATE LocalModeNe107CheckFunction
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация
END_VAR
